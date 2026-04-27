import Blob "mo:core/Blob";

import Sha256 "mo:sha2/Sha256";

import Common "../Common";
import Fp "../ec/Fp";
import Jacobi "../ec/Jacobi";
import Types "Types";

module {
  public type Signature = Types.Signature;
  public type PublicKey = Types.PublicKey;

  // Verify ECDSA signature using SHA256 as a hash function.
  public func verify(
    signature : Signature,
    publicKey : PublicKey,
    message : [Nat8],
  ) : Bool {

    let (x, y, curve) = (
      publicKey.coords.x,
      publicKey.coords.y,
      publicKey.curve,
    );

    if (
      signature.r == 0 or signature.s == 0 or
      signature.r >= curve.r or signature.s >= curve.r
    ) {
      return false;
    };

    let (r, s) : (Fp.Fp, Fp.Fp) = (curve.Fr(signature.r), curve.Fr(signature.s));
    let h : Fp.Fp = curve.Fr(Common.readBE256(Sha256.fromArray(#sha256, message).toArray(), 0));

    let sInverse : Fp.Fp = s.inverse();
    let a : Fp.Fp = h.mul(sInverse);
    let b : Fp.Fp = r.mul(sInverse);

    return switch (
      Jacobi.toAffine(
        Jacobi.add(
          Jacobi.mulBase(a.toNat(), curve),
          Jacobi.mul(Jacobi.fromAffine(#point(x, y, curve)), b.toNat()),
        )
      )
    ) {
      case (#point(x2, _, _)) {
        r.isEqual(curve.Fr(x2.toNat()));
      };
      case _ {
        false;
      };
    };
  };
};
