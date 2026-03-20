import Base58Check "../src/Base58Check";
import Bench "mo:bench";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";

module {
  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    bench.name("Base58Check encode/decode");
    bench.description("Benchmark Base58Check encode/decode across input sizes");

    bench.rows(["encode", "decode"]);
    bench.cols(["len 0", "len 10", "len 32", "len 64", "len 128"]);

    let mkData = func(len : Nat) : [Nat8] {
      Array.tabulate<Nat8>(len, func i { Nat8.fromNat((i * 13 + 7) % 256) });
    };

    let inputs : [[Nat8]] = [
      mkData(0),
      mkData(10),
      mkData(32),
      mkData(64),
      mkData(128),
    ];

    let encs : [Text] = Array.map<[Nat8], Text>(inputs, func a { Base58Check.encode(a) });

    bench.runner(
      func(row : Text, col : Text) {
        let idx = switch (col) {
          case ("len 0") 0;
          case ("len 10") 1;
          case ("len 32") 2;
          case ("len 64") 3;
          case ("len 128") 4;
          case (_) 0;
        };
        switch (row) {
          case ("encode") { ignore Base58Check.encode(inputs[idx]) };
          case ("decode") { ignore Base58Check.decode(encs[idx]) };
          case (_) {};
        };
      }
    );

    bench;
  };
};
