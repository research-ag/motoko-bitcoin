import Base58 "../src/Base58";
import Bench "mo:bench-helper";
import Array "mo:core/Array";
import Nat8 "mo:core/Nat8";
import Text "mo:core/Text";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "Base58 encode/decode";
      description = "Benchmark Base58 encode/decode across input sizes";
      rows = ["encode", "decode"];
      cols = ["len 0", "len 10", "len 32", "len 64", "len 128"];
    };

    let mkData = func(len : Nat) : [Nat8] {
      Array.tabulate<Nat8>(len, func i { Nat8.fromNat((i * 31 + 7) % 256) });
    };

    let inputs : [[Nat8]] = [
      mkData(0),
      mkData(10),
      mkData(32),
      mkData(64),
      mkData(128),
    ];

    let encs : [Text] = Array.map<[Nat8], Text>(inputs, func a { Base58.encode(a) });

    func run(ri : Nat, ci : Nat) {
        switch (ri) {
          case (0) { ignore Base58.encode(inputs[ci]) };
          case (1) { ignore Base58.decode(encs[ci]) };
          case (_) {};
        };
    };

    Bench.V1(schema, run);
  };
};
