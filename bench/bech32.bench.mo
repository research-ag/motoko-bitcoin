import Bech32 "../src/Bech32";
import Bench "mo:bench-helper";
import Array "mo:core/Array";
import Nat8 "mo:core/Nat8";
import Text "mo:core/Text";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "Bech32 vs Bech32m (encode)";
      description = "Compare Bech32 and Bech32m encoding across sizes";
      rows = ["bech32", "bech32m"];
      cols = ["len 0", "len 5", "len 20", "len 32"];
    };

    let hrps : [Text] = ["bc", "tb", "bcrt", "regtest"];
    let values : [[Nat8]] = [
      [],
      [0, 1, 2, 3, 4],
      Array.tabulate<Nat8>(20, func i { Nat8.fromNat((i * 7 + 3) % 32) }),
      Array.tabulate<Nat8>(32, func i { Nat8.fromNat((i * 11 + 5) % 32) }),
    ];

    func run(ri : Nat, ci : Nat) {
        let hrp = hrps[ci % hrps.size()];
        let v = values[ci];
        switch (ri) {
          case (0) {
            ignore Bech32.decode(Bech32.encode(hrp, v, #BECH32));
          };
          case (1) {
            ignore Bech32.decode(Bech32.encode(hrp, v, #BECH32M));
          };
          case (_) {};
        };
    };

    Bench.V1(schema, run);
  };
};
