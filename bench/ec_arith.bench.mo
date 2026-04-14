import Bench "mo:bench-helper";

import Affine "../src/ec/Affine";
import Curves "../src/ec/Curves";
import Jacobi "../src/ec/Jacobi";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "EC scalar mul: base vs arbitrary point";
      description = "Compare scalar multiplication using generator vs arbitrary point";
      rows = ["mulBase", "mulPoint"];
      cols = ["k small", "k medium", "k large"];
    };

    let curve = Curves.secp256k1;
    let gAff : Affine.Point = #point(curve.Fp(curve.gx), curve.Fp(curve.gy), curve);

    func run(ri : Nat, ci : Nat) {
      let k = switch (ci) {
        case (0) 12345;
        case (1) 123456789;
        case (2) 123456789123456789;
        case (_) 12345;
      };
      switch (ri) {
        case (0) {
          ignore Jacobi.toAffine(Jacobi.mulBase(k, curve));
        };
        case (1) {
          let p = Jacobi.fromAffine(gAff);
          ignore Jacobi.toAffine(Jacobi.mul(p, k));
        };
        case (_) {};
      };
    };

    Bench.V1(schema, run);
  };
};
