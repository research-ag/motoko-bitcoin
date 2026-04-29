import Fp "Fp";
import Mont "Mont";

module {
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
    // Montgomery contexts for arithmetic mod p (field) and mod r (scalar).
    mont_p : Mont.Ctx;
    mont_r : Mont.Ctx;
    // a in Montgomery form mod p (precomputed for use in EC point doubling).
    aMont : Nat;
    // Construct an Fp value mod p from a natural-form Nat.
    Fp : (Nat) -> Fp.Fp;
    // Construct an Fp value mod r from a natural-form Nat.
    Fr : (Nat) -> Fp.Fp;
  };

  let secp256k1_p : Nat = 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f;
  let secp256k1_r : Nat = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141;

  public func secp256k1() : Curve {
    let mont_p = Mont.ctx(secp256k1_p);
    let mont_r = Mont.ctx(secp256k1_r);
    let curve : Curve = {
      p = secp256k1_p;
      r = secp256k1_r;
      a = 0;
      b = 7;
      gx = 0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798;
      gy = 0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8;
      mont_p;
      mont_r;
      // a = 0 for secp256k1, and Mont.toMont(0, _) = 0, so aMont = 0.
      aMont = 0;
      Fp = func(value : Nat) : Fp.Fp = Fp.fromNat(value, mont_p);
      Fr = func(value : Nat) : Fp.Fp = Fp.fromNat(value, mont_r);
    };
    curve;
  };

  public func isEqual(curve1 : Curve, curve2 : Curve) : Bool {
    curve1.p == curve2.p and curve1.a == curve2.a and curve1.b == curve2.b and curve1.gx == curve2.gx and curve1.gy == curve2.gy
  };
};
