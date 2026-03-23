import Runtime "mo:core/Runtime";

import Bench "mo:bench-helper";

import Bip32 "../src/Bip32";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "BIP32 derivePath: text vs array";
      description = "Compare path representations for public derivation";
      rows = ["text", "array"];
      cols = ["depth 3", "depth 4", "depth 5"];
    };

    // Test xpubs
    let xpub = "xpub661MyMwAqRbcFtXgS5sYJABqqG9YLmC4Q1Rdap9gSE8NqtwybGhePY2gZ29ESFjqJoCu1Rupje8YtGqsefD265TMg7usUDFdp6W1EGMcet8";
    let ?ek = Bip32.parse(xpub, null) else Runtime.trap("Invalid benchmark xpub");

    func run(ri : Nat, ci : Nat) {
      let res = switch (ri, ci) {
        case (0, 0) ek.derivePath(#text "m/0/1/2");
        case (0, 1) ek.derivePath(#text "m/0/1/2/2");
        case (0, 2) ek.derivePath(#text "m/0/1/2/2/3");
        case (1, 0) ek.derivePath(#array([0, 1, 2]));
        case (1, 1) ek.derivePath(#array([0, 1, 2, 2]));
        case (1, 2) ek.derivePath(#array([0, 1, 2, 2, 3]));
        case _ null;
      };
      ignore res;
    };

    Bench.V1(schema, run);
  };
};
