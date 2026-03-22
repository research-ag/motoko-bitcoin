import Bech32 "../src/Bech32";
import Bench "mo:bench";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";

module {
  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    bench.name("Bech32 vs Bech32m (encode)");
    bench.description("Compare Bech32 and Bech32m encoding across sizes");

    bench.rows(["bech32", "bech32m"]);
    bench.cols(["len 0", "len 5", "len 20", "len 32"]);

    let hrps : [Text] = ["bc", "tb", "bcrt", "regtest"];
    let values : [[Nat8]] = [
      [],
      [0, 1, 2, 3, 4],
      Array.tabulate<Nat8>(20, func i { Nat8.fromNat((i * 7 + 3) % 32) }),
      Array.tabulate<Nat8>(32, func i { Nat8.fromNat((i * 11 + 5) % 32) }),
    ];

    bench.runner(
      func(row : Text, col : Text) {
        let i = switch (col) {
          case ("len 0") 0;
          case ("len 5") 1;
          case ("len 20") 2;
          case ("len 32") 3;
          case (_) 0;
        };
        let hrp = hrps[i % hrps.size()];
        let v = values[i];
        switch (row) {
          case ("bech32") {
            ignore Bech32.decode(Bech32.encode(hrp, v, #BECH32));
          };
          case ("bech32m") {
            ignore Bech32.decode(Bech32.encode(hrp, v, #BECH32M));
          };
          case (_) {};
        };
      }
    );

    bench;
  };
};
