import Hmac "../src/Hmac";
import Bench "mo:bench";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Blob "mo:base/Blob";

module {
  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    bench.name("HMAC: SHA256 vs SHA512");
    bench.description("Compare HMAC-SHA256 and HMAC-SHA512 across message sizes");

    bench.rows(["HMAC-SHA256", "HMAC-SHA512"]);
    bench.cols(["len 0", "len 32", "len 64", "len 256"]);

    let keys : [[Nat8]] = [
      Array.tabulate<Nat8>(16, func i { Nat8.fromNat((i * 9 + 2) % 256) }),
      Array.tabulate<Nat8>(64, func i { Nat8.fromNat((i * 5 + 3) % 256) }),
    ];

    let datas : [[Nat8]] = [
      [],
      Array.tabulate<Nat8>(32, func i { Nat8.fromNat((i * 3 + 1) % 256) }),
      Array.tabulate<Nat8>(64, func i { Nat8.fromNat((i * 7 + 5) % 256) }),
      Array.tabulate<Nat8>(256, func i { Nat8.fromNat((i * 11 + 13) % 256) }),
    ];

    bench.runner(
      func(row : Text, col : Text) {
        let di = switch (col) {
          case ("len 0") 0;
          case ("len 32") 1;
          case ("len 64") 2;
          case ("len 256") 3;
          case (_) 0;
        };
        let msg = datas[di];
        switch (row) {
          case ("HMAC-SHA256") {
            let h = Hmac.sha256(keys[0]);
            h.writeArray(msg);
            ignore Blob.toArray(h.sum());
          };
          case ("HMAC-SHA512") {
            let h = Hmac.sha512(keys[1]);
            h.writeArray(msg);
            ignore Blob.toArray(h.sum());
          };
          case (_) {};
        };
      }
    );

    bench;
  };
};
