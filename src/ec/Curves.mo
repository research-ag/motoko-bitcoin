/// Elliptic curve parameter definitions.
///
/// ```motoko name=import
/// import Curves "mo:bitcoin/ec/Curves";
/// ```

import Fp "Fp";

module {
  /// Prime-field short Weierstrass curve parameters.
  ///
  /// Defines a curve `y^2 = x^3 + a*x + b` over `F_p` with subgroup
  /// order `r` and generator `(gx, gy)`. `Fp` is a convenience constructor
  /// for field elements modulo `p`.
  public type Curve = {
    p : Nat;
    // Order (number of points on the curve)
    r : Nat;
    // a and b from  y^2 = x^3 + ax + b
    a : Nat;
    b : Nat;
    // Generator point
    gx : Nat;
    gy : Nat;
    Fp : (Nat) -> Fp.Fp;
  };

  /// secp256k1 curve definition.
  public let secp256k1 : Curve = {
    p = 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f;
    r = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141;
    a = 0;
    b = 7;
    gx = 0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798;
    gy = 0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8;
    Fp = func(value : Nat) : Fp.Fp {
      Fp.Fp(value, secp256k1.p);
    };
  };

  /// Compares two curves by core domain parameters.
  ///
  /// Compares `p`, `a`, `b`, `gx`, and `gy`. Does not compare the cofactor
  /// or the embedded `Fp` constructor function. Never traps.
  public func isEqual(curve1 : Curve, curve2 : Curve) : Bool {
    curve1.p == curve2.p and curve1.a == curve2.a and curve1.b == curve2.b and curve1.gx == curve2.gx and curve1.gy == curve2.gy
  };
};
