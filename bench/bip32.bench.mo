import Bip32 "../src/Bip32";
import Bench "mo:bench";

module {
  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    bench.name("BIP32 derivePath: text vs array");
    bench.description("Compare path representations for public derivation");

    bench.rows(["text", "array"]);
    bench.cols(["depth 3", "depth 4", "depth 5"]);

    // Test xpubs
    let xpub = "xpub661MyMwAqRbcFtXgS5sYJABqqG9YLmC4Q1Rdap9gSE8NqtwybGhePY2gZ29ESFjqJoCu1Rupje8YtGqsefD265TMg7usUDFdp6W1EGMcet8";

    bench.runner(
      func(row : Text, col : Text) {
        switch (Bip32.parse(xpub, null)) {
          case (?ek) {
            let res = switch (row, col) {
              case (("text"), ("depth 3")) ek.derivePath(#text "m/0/1/2");
              case (("text"), ("depth 4")) ek.derivePath(#text "m/0/1/2/2");
              case (("text"), ("depth 5")) ek.derivePath(#text "m/0/1/2/2/3");
              case (("array"), ("depth 3")) ek.derivePath(#array([0, 1, 2]));
              case (("array"), ("depth 4")) ek.derivePath(#array([0, 1, 2, 2]));
              case (("array"), ("depth 5")) ek.derivePath(#array([0, 1, 2, 2, 3]));
              case _ null;
            };
            ignore res;
          };
          case null {};
        };
      }
    );

    bench;
  };
};
