import Curves "../src/ec/Curves";
import Jacobi "../src/ec/Jacobi";
import Affine "../src/ec/Affine";
import Bench "mo:bench";

module {
  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    bench.name("EC scalar mul: base vs arbitrary point");
    bench.description("Compare scalar multiplication using generator vs arbitrary point");

    bench.rows(["mulBase", "mulPoint"]);
    bench.cols(["k small", "k medium", "k large"]);

    let curve = Curves.secp256k1;
    let gAff : Affine.Point = #point(curve.Fp(curve.gx), curve.Fp(curve.gy), curve);

    bench.runner(
      func(row : Text, col : Text) {
        let k = switch (col) {
          case ("k small") 12345;
          case ("k medium") 123456789;
          case ("k large") 123456789123456789;
          case (_) 12345;
        };
        switch (row) {
          case ("mulBase") {
            ignore Jacobi.toAffine(Jacobi.mulBase(k, curve));
          };
          case ("mulPoint") {
            let p = Jacobi.fromAffine(gAff);
            ignore Jacobi.toAffine(Jacobi.mul(p, k));
          };
          case (_) {};
        };
      }
    );

    bench;
  };
};
