// EC operations using Jacobian coordinates.
//
// Field elements are kept in Montgomery form throughout: doubling and
// addition formulas operate on `Nat` values in [0, p) representing `xR mod p`
// (R = 2^256). Mont add/sub/neg are linear; Mont mul/sqr go through `redc`.
//
// This implementation is intended for use within Internet Computer canisters
// which must only execute public operations. The code does not account for
// side-channels as they're not relevant to the use case.
//
// Therefore, DO NOT use this code for any operations involving secrets.

import Nat "mo:core/Nat";
import Int "mo:core/Int";
import Runtime "mo:core/Runtime";

import Affine "Affine";
import Curves "Curves";
import BaseFp "Fp";
import Mont "Mont";
import Numbers "Numbers";

module {
  type Fp = BaseFp.Fp;

  public type Point = {
    #infinity : Curves.Curve;
    #point : (Fp, Fp, Fp, Curves.Curve);
  };

  // Deserialize given data into a point on the given curve. This supports
  // compressed and uncompressed SEC-1 formats.
  // Returns null if data is not in correct format, data size is not exactly
  // equal to the serialized point size, or if deserialized point is not on the
  // given curve.
  public func fromBytes(data : [Nat8], curve : Curves.Curve) : ?Point {
    switch (Affine.fromBytes(data, curve)) {
      case (null) null;
      case (?(#infinity(curve))) ?(#infinity(curve));
      case (?#point(x, y, curve)) ?#point(x, y, curve.Fp(1), curve);
    };
  };

  // Serialize given point to bytes in SEC-1 format.
  public func toBytes(point : Point, compressed : Bool) : [Nat8] {
    Affine.toBytes(toAffine(point), compressed);
  };

  // Check if the given point is valid.
  public func isOnCurve(point : Point) : Bool {
    Affine.isOnCurve(toAffine(point));
  };

  // Convert given point from affine coordinates to jacobi coordinates
  public func fromAffine(point : Affine.Point) : Point {
    switch point {
      case (#infinity(curve)) #infinity(curve);
      case (#point(x, y, curve)) #point(x, y, curve.Fp(1), curve);
    };
  };

  // Create a jacobi point from the given coordinates.
  // Returns null if the point is not valid.
  public func fromNat(x : Nat, y : Nat, z : Nat, curve : Curves.Curve) : ?Point {
    ?(#point(curve.Fp(x), curve.Fp(y), curve.Fp(z), curve));
  };

  // Return the base point of the given curve.
  public func base(curve : Curves.Curve) : Point {
    #point(curve.Fp(curve.gx), curve.Fp(curve.gy), curve.Fp(1), curve);
  };

  // Check if the two given jacobi points are equal.
  public func isEqual(point1 : Point, point2 : Point) : Bool {
    switch (normalizeInfinity(point1), normalizeInfinity(point2)) {
      case (#infinity(curve1), #infinity(curve2)) {
        Curves.isEqual(curve1, curve2);
      };
      case (#point(x1, y1, z1, curve1), #point(x2, y2, z2, curve2)) {
        if (not Curves.isEqual(curve1, curve2)) {
          false;
        } else {
          let zz1 = z1.sqr();
          let zz2 = z2.sqr();

          (x1.mul(zz2).isEqual(x2.mul(zz1))) and (y1.mul(zz2).mul(z2).isEqual(y2.mul(zz1.mul(z1))));
        };
      };
      case (_) false;
    };
  };

  // Check if the given point is the point at infinity.
  public func isInfinity(point : Point) : Bool {
    switch point {
      case (#infinity(_)) true;
      case (#point(_, _, z, curve)) z.isEqual(curve.Fp(0));
    };
  };

  // Convert the given jacobi point to affine.
  public func toAffine(point : Point) : Affine.Point {
    let scaledPoint = scale(point);
    switch scaledPoint {
      case (#infinity(curve)) #infinity(curve);
      case (#point(x, y, _, curve)) #point(x, y, curve);
    };
  };

  // Invert the given point on the x-axis.
  public func neg(point : Point) : Point {
    switch (normalizeInfinity(point)) {
      case (#infinity(curve)) #infinity(curve);
      case (#point(x, y, z, curve)) #point(x, y.neg(), z, curve);
    };
  };

  // Normalize the given point such that z = 1.
  public func scale(point : Point) : Point {
    switch (normalizeInfinity(point)) {
      case (#infinity(curve)) #infinity(curve);
      case (#point(x, y, z, curve)) {
        if (z.isEqual(curve.Fp(1))) {
          return point;
        };

        let zInverse = z.inverse();
        let zzInverse = zInverse.sqr();

        let newX = x.mul(zzInverse);
        let newY = y.mul(zzInverse).mul(zInverse);
        let newZ = curve.Fp(1);

        #point(newX, newY, newZ, curve);
      };
    };
  };

  // Return double of the given point.
  public func double(point : Point) : Point {
    switch (normalizeInfinity(point)) {
      case (#infinity(curve)) #infinity(curve);
      case (#point(x, y, z, curve)) {
        let ctx = curve.mont_p;
        let (x2, y2, z2) = doDouble(x.value, y.value, z.value, curve.aMont, ctx);
        #point(
          BaseFp.Fp(x2, ctx),
          BaseFp.Fp(y2, ctx),
          BaseFp.Fp(z2, ctx),
          curve,
        );
      };
    };
  };

  // Multiply the given point by the given scalar value.
  public func mul(point : Point, other : Nat) : Point {
    if (other == 0) {
      return #infinity(getCurve(point));
    };
    switch (scale(point)) {
      case (#infinity(curve)) #infinity(curve);
      case (#point(x2, y2, _, curve)) {
        switch (curve.glv) {
          case (?glv) return mulGlv(x2, y2, other, glv, curve);
          case null {};
        };
        let ctx = curve.mont_p;
        let aM = curve.aMont;
        var p : (Nat, Nat, Nat) = (0, 0, ctx.one);
        let naf = Numbers.toNaf(other);
        let y2neg = y2.neg().value;

        for (i in Nat.rangeByInclusive(naf.size() - 1, 0, -1)) {
          let nafItem : Int = naf[i];
          p := doDouble(p.0, p.1, p.2, aM, ctx);
          if (nafItem < 0) {
            p := _add(p.0, p.1, p.2, x2.value, y2neg, ctx.one, aM, ctx);
          } else if (nafItem > 0) {
            p := _add(p.0, p.1, p.2, x2.value, y2.value, ctx.one, aM, ctx);
          };
        };
        if (p.1 == 0 or p.2 == 0) {
          return #infinity(curve);
        };
        #point(
          BaseFp.Fp(p.0, ctx),
          BaseFp.Fp(p.1, ctx),
          BaseFp.Fp(p.2, ctx),
          curve,
        );
      };
    };
  };

  // Scalar multiplication using the GLV endomorphism. Decomposes the scalar
  // `k mod r` into `(k1, k2)` such that `k1 + lambda * k2 == k (mod r)` and
  // both halves are roughly half the bit-length of `r`. Then computes
  // `k1 * P + k2 * phi(P)` with a Straus/Shamir-style interleaved-NAF loop,
  // where `phi(X, Y, Z) = (beta * X, Y, Z)` in Jacobian coordinates.
  // Field elements are kept in Montgomery form throughout, matching the rest
  // of the Jacobian inner formulas. Caller guarantees `(x, y)` is the affine
  // (Z=1) representation of P (in Mont form) and that `scalar != 0`.
  func mulGlv(
    x : Fp,
    y : Fp,
    scalar : Nat,
    glv : Curves.Glv,
    curve : Curves.Curve,
  ) : Point {
    let ctx = curve.mont_p;
    let aM = curve.aMont;

    let n : Int = curve.r;
    let k : Int = scalar % curve.r;
    if (k == 0) {
      return #infinity(curve);
    };
    let halfN : Int = n / 2;

    // Both `b2` and `-b1` are positive for valid GLV bases, so the numerators
    // are non-negative and Motoko's truncating Int division yields rounding
    // to nearest (with halves rounded away from zero, which is acceptable).
    let c1 : Int = (glv.b2 * k + halfN) / n;
    let c2 : Int = (-glv.b1 * k + halfN) / n;
    let k1 : Int = k - c1 * glv.a1 - c2 * glv.a2;
    let k2 : Int = -c1 * glv.b1 - c2 * glv.b2;

    let absK1 = Int.abs(k1);
    let absK2 = Int.abs(k2);

    // Precompute base points and their negations, all in Mont form.
    let p1x = x.value;
    let yPos = y.value;
    let yNeg = Mont.neg(yPos, ctx);
    let p1y = if (k1 < 0) yNeg else yPos;
    let p1yAlt = if (k1 < 0) yPos else yNeg;
    let p2x = Mont.mul(x.value, glv.betaMont, ctx);
    let p2y = if (k2 < 0) yNeg else yPos;
    let p2yAlt = if (k2 < 0) yPos else yNeg;

    let naf1 = Numbers.toNaf(absK1);
    let naf2 = Numbers.toNaf(absK2);
    let len = if (naf1.size() > naf2.size()) naf1.size() else naf2.size();

    var p : (Nat, Nat, Nat) = (0, 0, ctx.one);
    for (i in Nat.rangeByInclusive(len - 1, 0, -1)) {
      p := doDouble(p.0, p.1, p.2, aM, ctx);
      if (i < naf1.size()) {
        let d : Int = naf1[i];
        if (d > 0) {
          p := _add(p.0, p.1, p.2, p1x, p1y, ctx.one, aM, ctx);
        } else if (d < 0) {
          p := _add(p.0, p.1, p.2, p1x, p1yAlt, ctx.one, aM, ctx);
        };
      };
      if (i < naf2.size()) {
        let d : Int = naf2[i];
        if (d > 0) {
          p := _add(p.0, p.1, p.2, p2x, p2y, ctx.one, aM, ctx);
        } else if (d < 0) {
          p := _add(p.0, p.1, p.2, p2x, p2yAlt, ctx.one, aM, ctx);
        };
      };
    };
    if (p.1 == 0 or p.2 == 0) {
      return #infinity(curve);
    };
    #point(
      BaseFp.Fp(p.0, ctx),
      BaseFp.Fp(p.1, ctx),
      BaseFp.Fp(p.2, ctx),
      curve,
    );
  };

  // Multiply the base point of the given curve by the given scalar value.
  public func mulBase(other : Nat, curve : Curves.Curve) : Point {
    mul(base(curve), other);
  };

  // Add the given two points.
  public func add(point1 : Point, point2 : Point) : Point {
    if (not Curves.isEqual(getCurve(point1), getCurve(point2))) {
      Runtime.trap("Cannot add two points on different curves");
    };

    switch (normalizeInfinity(point1), normalizeInfinity(point2)) {
      case (#infinity(curve), #infinity(_)) #infinity(curve);
      case (#infinity(_), _) point2;
      case (_, #infinity(_)) point1;
      case (#point(X1, Y1, Z1, curve), #point(X2, Y2, Z2, _)) {
        let ctx = curve.mont_p;
        let (X3, Y3, Z3) = _add(
          X1.value,
          Y1.value,
          Z1.value,
          X2.value,
          Y2.value,
          Z2.value,
          curve.aMont,
          ctx,
        );
        if (Y3 == 0 or Z3 == 0) {
          #infinity(curve);
        } else {
          #point(
            BaseFp.Fp(X3, ctx),
            BaseFp.Fp(Y3, ctx),
            BaseFp.Fp(Z3, ctx),
            curve,
          );
        };
      };
    };
  };

  // ---- Mont-form Jacobian inner formulas. ----
  // All inputs/outputs are Nat in [0, p) representing field elements in
  // Montgomery form (xR mod p, R = 2^256). aM is the curve's `a` parameter
  // also in Montgomery form. ctx carries the Montgomery context (n, mp, r2,
  // one).

  func doDouble(X1 : Nat, Y1 : Nat, Z1 : Nat, aM : Nat, ctx : Mont.Ctx) : (Nat, Nat, Nat) {
    if (Z1 == ctx.one) {
      return doubleWithZ1(X1, Y1, aM, ctx);
    };
    if (Y1 == 0 or Z1 == 0) {
      return (0, 0, 0);
    };

    let XX = Mont.sqr(X1, ctx);
    let YY = Mont.sqr(Y1, ctx);
    let YYYY = Mont.sqr(YY, ctx);
    let ZZ = Mont.sqr(Z1, ctx);

    // S = 2 * ((X1 + YY)^2 - XX - YYYY)
    let X1pYY = Mont.add(X1, YY, ctx);
    let X1pYY_sq = Mont.sqr(X1pYY, ctx);
    let inner = Mont.sub(Mont.sub(X1pYY_sq, XX, ctx), YYYY, ctx);
    let S = Mont.add(inner, inner, ctx);

    // M = 3*XX + a*ZZ^2
    let three_XX = Mont.add(Mont.add(XX, XX, ctx), XX, ctx);
    let M = if (aM == 0) {
      three_XX;
    } else {
      Mont.add(three_XX, Mont.mul(aM, Mont.sqr(ZZ, ctx), ctx), ctx);
    };

    // T = M^2 - 2S
    let M2 = Mont.sqr(M, ctx);
    let twoS = Mont.add(S, S, ctx);
    let T = Mont.sub(M2, twoS, ctx);

    // Y3 = M*(S - T) - 8*YYYY
    let SsubT = Mont.sub(S, T, ctx);
    let MSsubT = Mont.mul(M, SsubT, ctx);
    let YY2 = Mont.add(YYYY, YYYY, ctx);
    let YY4 = Mont.add(YY2, YY2, ctx);
    let YY8 = Mont.add(YY4, YY4, ctx);
    let Y3 = Mont.sub(MSsubT, YY8, ctx);

    // Z3 = (Y1 + Z1)^2 - YY - ZZ
    let Y1pZ1 = Mont.add(Y1, Z1, ctx);
    let Y1pZ1_sq = Mont.sqr(Y1pZ1, ctx);
    let Z3 = Mont.sub(Mont.sub(Y1pZ1_sq, YY, ctx), ZZ, ctx);

    return (T, Y3, Z3);
  };

  func doubleWithZ1(X1 : Nat, Y1 : Nat, aM : Nat, ctx : Mont.Ctx) : (Nat, Nat, Nat) {
    if (Y1 == 0) {
      return (0, 0, 0);
    };

    let XX = Mont.sqr(X1, ctx);
    let YY = Mont.sqr(Y1, ctx);
    let YYYY = Mont.sqr(YY, ctx);

    let X1pYY = Mont.add(X1, YY, ctx);
    let X1pYY_sq = Mont.sqr(X1pYY, ctx);
    let inner = Mont.sub(Mont.sub(X1pYY_sq, XX, ctx), YYYY, ctx);
    let S = Mont.add(inner, inner, ctx);

    // Z = 1, so M = 3*XX + a (in Mont form, a is aM).
    let three_XX = Mont.add(Mont.add(XX, XX, ctx), XX, ctx);
    let M = if (aM == 0) three_XX else Mont.add(three_XX, aM, ctx);

    let M2 = Mont.sqr(M, ctx);
    let twoS = Mont.add(S, S, ctx);
    let T = Mont.sub(M2, twoS, ctx);

    let SsubT = Mont.sub(S, T, ctx);
    let MSsubT = Mont.mul(M, SsubT, ctx);
    let YY2 = Mont.add(YYYY, YYYY, ctx);
    let YY4 = Mont.add(YY2, YY2, ctx);
    let YY8 = Mont.add(YY4, YY4, ctx);
    let Y3 = Mont.sub(MSsubT, YY8, ctx);

    // Z3 = 2 * Y1
    let Z3 = Mont.add(Y1, Y1, ctx);

    return (T, Y3, Z3);
  };

  func addWithEqZ(
    X1 : Nat,
    Y1 : Nat,
    Z1 : Nat,
    X2 : Nat,
    Y2 : Nat,
    aM : Nat,
    ctx : Mont.Ctx,
  ) : (Nat, Nat, Nat) {

    let dX = Mont.sub(X2, X1, ctx);
    let A = Mont.sqr(dX, ctx);
    let B = Mont.mul(X1, A, ctx);
    let C_ = Mont.mul(X2, A, ctx);
    let dY = Mont.sub(Y2, Y1, ctx);
    let D = Mont.sqr(dY, ctx);

    if (A == 0 and D == 0) {
      return doDouble(X1, Y1, Z1, aM, ctx);
    };

    let X3 = Mont.sub(Mont.sub(D, B, ctx), C_, ctx);
    let CsubB = Mont.sub(C_, B, ctx);
    let BsubX3 = Mont.sub(B, X3, ctx);
    let Y3 = Mont.sub(Mont.mul(dY, BsubX3, ctx), Mont.mul(Y1, CsubB, ctx), ctx);
    let Z3 = Mont.mul(Z1, dX, ctx);

    return (X3, Y3, Z3);
  };

  func addWithZ1(
    X1 : Nat,
    Y1 : Nat,
    X2 : Nat,
    Y2 : Nat,
    aM : Nat,
    ctx : Mont.Ctx,
  ) : (Nat, Nat, Nat) {
    let H = Mont.sub(X2, X1, ctx);
    let HH = Mont.sqr(H, ctx);
    let HH2 = Mont.add(HH, HH, ctx);
    let I = Mont.add(HH2, HH2, ctx);
    let J = Mont.mul(H, I, ctx);
    let dY = Mont.sub(Y2, Y1, ctx);
    let r = Mont.add(dY, dY, ctx);

    if (H == 0 and r == 0) {
      return doubleWithZ1(X1, Y1, aM, ctx);
    };

    let V = Mont.mul(X1, I, ctx);
    let r_sq = Mont.sqr(r, ctx);
    let twoV = Mont.add(V, V, ctx);
    let X3 = Mont.sub(Mont.sub(r_sq, J, ctx), twoV, ctx);
    let VsubX3 = Mont.sub(V, X3, ctx);
    let r_VsubX3 = Mont.mul(r, VsubX3, ctx);
    let Y1J = Mont.mul(Y1, J, ctx);
    let twoY1J = Mont.add(Y1J, Y1J, ctx);
    let Y3 = Mont.sub(r_VsubX3, twoY1J, ctx);
    let Z3 = Mont.add(H, H, ctx);

    return (X3, Y3, Z3);
  };

  func addWithZ2Eq1(
    X1 : Nat,
    Y1 : Nat,
    Z1 : Nat,
    X2 : Nat,
    Y2 : Nat,
    aM : Nat,
    ctx : Mont.Ctx,
  ) : (Nat, Nat, Nat) {

    let Z1Z1 = Mont.sqr(Z1, ctx);
    let U2 = Mont.mul(X2, Z1Z1, ctx);
    let S2 = Mont.mul(Mont.mul(Y2, Z1, ctx), Z1Z1, ctx);
    let H = Mont.sub(U2, X1, ctx);
    let HH = Mont.sqr(H, ctx);
    let HH2 = Mont.add(HH, HH, ctx);
    let I = Mont.add(HH2, HH2, ctx);
    let J = Mont.mul(H, I, ctx);
    let dS = Mont.sub(S2, Y1, ctx);
    let r = Mont.add(dS, dS, ctx);

    if (r == 0 and H == 0) {
      return doubleWithZ1(X2, Y2, aM, ctx);
    };

    let V = Mont.mul(X1, I, ctx);
    let r_sq = Mont.sqr(r, ctx);
    let twoV = Mont.add(V, V, ctx);
    let X3 = Mont.sub(Mont.sub(r_sq, J, ctx), twoV, ctx);
    let VsubX3 = Mont.sub(V, X3, ctx);
    let r_VsubX3 = Mont.mul(r, VsubX3, ctx);
    let Y1J = Mont.mul(Y1, J, ctx);
    let twoY1J = Mont.add(Y1J, Y1J, ctx);
    let Y3 = Mont.sub(r_VsubX3, twoY1J, ctx);
    let Z1pH = Mont.add(Z1, H, ctx);
    let Z1pH_sq = Mont.sqr(Z1pH, ctx);
    let Z3 = Mont.sub(Mont.sub(Z1pH_sq, Z1Z1, ctx), HH, ctx);

    return (X3, Y3, Z3);
  };

  func addWithArbitraryZ(
    X1 : Nat,
    Y1 : Nat,
    Z1 : Nat,
    X2 : Nat,
    Y2 : Nat,
    Z2 : Nat,
    aM : Nat,
    ctx : Mont.Ctx,
  ) : (Nat, Nat, Nat) {

    let Z1Z1 = Mont.sqr(Z1, ctx);
    let Z2Z2 = Mont.sqr(Z2, ctx);
    let U1 = Mont.mul(X1, Z2Z2, ctx);
    let U2 = Mont.mul(X2, Z1Z1, ctx);
    let S1 = Mont.mul(Mont.mul(Y1, Z2, ctx), Z2Z2, ctx);
    let S2 = Mont.mul(Mont.mul(Y2, Z1, ctx), Z1Z1, ctx);
    let H = Mont.sub(U2, U1, ctx);
    let dS = Mont.sub(S2, S1, ctx);
    let r = Mont.add(dS, dS, ctx);

    if (H == 0 and r == 0) {
      return doDouble(X1, Y1, Z1, aM, ctx);
    };

    let HH = Mont.sqr(H, ctx);
    let HH2 = Mont.add(HH, HH, ctx);
    let I = Mont.add(HH2, HH2, ctx);
    let J = Mont.mul(H, I, ctx);
    let V = Mont.mul(U1, I, ctx);
    let r_sq = Mont.sqr(r, ctx);
    let twoV = Mont.add(V, V, ctx);
    let X3 = Mont.sub(Mont.sub(r_sq, J, ctx), twoV, ctx);
    let VsubX3 = Mont.sub(V, X3, ctx);
    let r_VsubX3 = Mont.mul(r, VsubX3, ctx);
    let S1J = Mont.mul(S1, J, ctx);
    let twoS1J = Mont.add(S1J, S1J, ctx);
    let Y3 = Mont.sub(r_VsubX3, twoS1J, ctx);
    let Z1pZ2 = Mont.add(Z1, Z2, ctx);
    let Z1pZ2_sq = Mont.sqr(Z1pZ2, ctx);
    let inner = Mont.sub(Mont.sub(Z1pZ2_sq, Z1Z1, ctx), Z2Z2, ctx);
    let Z3 = Mont.mul(inner, H, ctx);

    return (X3, Y3, Z3);
  };

  func _add(
    X1 : Nat,
    Y1 : Nat,
    Z1 : Nat,
    X2 : Nat,
    Y2 : Nat,
    Z2 : Nat,
    aM : Nat,
    ctx : Mont.Ctx,
  ) : (Nat, Nat, Nat) {

    if (Y1 == 0 or Z1 == 0) {
      return (X2, Y2, Z2);
    };

    if (Y2 == 0 or Z2 == 0) {
      return (X1, Y1, Z1);
    };

    if (Z1 == Z2) {
      if (Z1 == ctx.one) {
        return addWithZ1(X1, Y1, X2, Y2, aM, ctx);
      };
      return addWithEqZ(X1, Y1, Z1, X2, Y2, aM, ctx);
    };

    if (Z1 == ctx.one) {
      return addWithZ2Eq1(X2, Y2, Z2, X1, Y1, aM, ctx);
    };

    if (Z2 == ctx.one) {
      return addWithZ2Eq1(X1, Y1, Z1, X2, Y2, aM, ctx);
    };

    return addWithArbitraryZ(X1, Y1, Z1, X2, Y2, Z2, aM, ctx);
  };

  // Normalizes infinity point of the form #point (_, _, 0, _) to #infinity.
  func normalizeInfinity(point : Point) : Point {
    if (isInfinity(point)) {
      #infinity(getCurve(point));
    } else {
      point;
    };
  };

  // Extracts the curve from the given point.
  func getCurve(point : Point) : Curves.Curve {
    switch (point) {
      case (#infinity(curve)) curve;
      case (#point(_, _, _, curve)) curve;
    };
  };
};
