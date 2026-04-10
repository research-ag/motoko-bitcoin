import Array "mo:core/Array";
import Nat8 "mo:core/Nat8";

import Bench "mo:bench-helper";

import Bech32 "../src/Bech32";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "Bech32 vs Bech32m (encode)";
      description = "Compare Bech32 and Bech32m encoding across sizes";
      rows = ["encode bech32", "encode bech32m", "decode bech32", "decode bech32m"];
      cols = ["len 0", "len 5", "len 20", "len 32"];
    };

    let values : [[Nat8]] = [
      [],
      [0, 1, 2, 3, 4],
      Array.tabulate<Nat8>(20, func i { Nat8.fromNat((i * 7 + 3) % 32) }),
      Array.tabulate<Nat8>(32, func i { Nat8.fromNat((i * 11 + 5) % 32) }),
    ];

    let hrp = "bc";

    let encoded_values = values.map(func(v) { Bech32.encode(hrp, v, #BECH32) });
    let encoded_values_m = values.map(func(v) { Bech32.encode(hrp, v, #BECH32M) });

    func run(ri : Nat, ci : Nat) {
      switch (ri) {
        case (0) {
          ignore Bech32.encode(hrp, values[ci], #BECH32);
        };
        case (1) {
          ignore Bech32.encode(hrp, values[ci], #BECH32M);
        };
        case (2) {
          ignore Bech32.decode(encoded_values[ci]);
        };
        case (3) {
          ignore Bech32.decode(encoded_values_m[ci]);
        };
        case (_) {};
      };
    };

    Bench.V1(schema, run);
  };
};
