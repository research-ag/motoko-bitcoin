import Affine "../ec/Affine";
import Curves "../ec/Curves";
import Fp "../ec/Fp";

module {
  public type PrivateKey = Nat;
  public type PublicKey = {
    coords : {
      x : Fp.Fp;
      y : Fp.Fp;
    };
    curve : Curves.Curve;
  };

  public type Sec1PublicKey = ([Nat8], Curves.Curve);
  public type EncodedPublicKey = {
    #sec1 : Sec1PublicKey;
    #point : Affine.Point;
  };

  public type Signature = { r : Nat; s : Nat };
  public type DerSignature = Blob;
  public type EncodedSignature = {
    #der : DerSignature;
  };
};
