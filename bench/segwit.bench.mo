import Array "mo:core/Array";
import Nat8 "mo:core/Nat8";
import Runtime "mo:core/Runtime";
import Text "mo:core/Text";

import Bench "mo:bench-helper";

import Segwit "../src/Segwit";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "SegWit (address encode/decode)";
      description = "Benchmark SegWit Bech32/Bech32m address encode/decode for common versions and program lengths";
      rows = ["encode", "decode"];
      cols = [
        "bc v0/20",
        "bc v0/32",
        "bc v1/32",
        "tb v0/20",
        "tb v0/32",
        "tb v1/32",
      ];
    };

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
          case (#err(msg)) { Runtime.trap("Segwit.encode failed: " # msg) };
        };
      },
    );

    func run(ri : Nat, ci : Nat) {
      switch (ri) {
        case (0) { ignore Segwit.encode(hrps[ci], wps[ci]) };
        case (1) { ignore Segwit.decode(addrs[ci]) };
        case (_) {};
      };
    };

    Bench.V1(schema, run);
  };
};
