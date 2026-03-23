import Segwit "../src/Segwit";
import Bench "mo:bench";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";
import Debug "mo:base/Debug";

module {
  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    bench.name("SegWit (address encode/decode)");
    bench.description("Benchmark SegWit Bech32/Bech32m address encode/decode for common versions and program lengths");

    bench.rows(["encode", "decode"]);
    bench.cols([
      "bc v0/20",
      "bc v0/32",
      "bc v1/32",
      "tb v0/20",
      "tb v0/32",
      "tb v1/32",
    ]);

    let mkProg = func(len : Nat) : [Nat8] {
      Array.tabulate<Nat8>(len, func i { Nat8.fromNat((i * 13 + 7) % 256) });
    };

    let hrps : [Text] = ["bc", "bc", "bc", "tb", "tb", "tb"];

    let wps = [
      { version = 0 : Nat8; program = mkProg(20) },
      { version = 0 : Nat8; program = mkProg(32) },
      { version = 1 : Nat8; program = mkProg(32) },
      { version = 0 : Nat8; program = mkProg(20) },
      { version = 0 : Nat8; program = mkProg(32) },
      { version = 1 : Nat8; program = mkProg(32) },
    ];

    let addrs : [Text] = Array.tabulate<Text>(
      wps.size(),
      func i {
        switch (Segwit.encode(hrps[i], wps[i])) {
          case (#ok(addr)) { addr };
          case (#err(msg)) { Debug.trap("Segwit.encode failed: " # msg) };
        };
      },
    );

    bench.runner(
      func(row : Text, col : Text) {
        let ci = switch (col) {
          case ("bc v0/20") 0;
          case ("bc v0/32") 1;
          case ("bc v1/32") 2;
          case ("tb v0/20") 3;
          case ("tb v0/32") 4;
          case ("tb v1/32") 5;
          case (_) 0;
        };
        switch (row) {
          case ("encode") ignore Segwit.encode(hrps[ci], wps[ci]);
          case ("decode") ignore Segwit.decode(addrs[ci]);
          case (_) {};
        };
      }
    );

    bench;
  };
};
