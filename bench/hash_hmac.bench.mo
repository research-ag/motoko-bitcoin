import Hmac "../src/Hmac";
import Bench "mo:bench-helper";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Blob "mo:base/Blob";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "HMAC: SHA256 vs SHA512";
      description = "Compare HMAC-SHA256 and HMAC-SHA512 across message sizes";
      rows = ["HMAC-SHA256", "HMAC-SHA512"];
      cols = ["len 0", "len 32", "len 64", "len 256"];
    };

    let key : [Nat8] = Array.tabulate<Nat8>(64, func i { Nat8.fromNat((i * 5 + 3) % 256) });

    let datas : [[Nat8]] = [
      [],
      Array.tabulate<Nat8>(32, func i { Nat8.fromNat((i * 3 + 1) % 256) }),
      Array.tabulate<Nat8>(64, func i { Nat8.fromNat((i * 7 + 5) % 256) }),
      Array.tabulate<Nat8>(256, func i { Nat8.fromNat((i * 11 + 13) % 256) }),
    ];

    func run(ri : Nat, ci : Nat) {
        let msg = datas[ci];
        switch (ri) {
          case (0) {
            let h = Hmac.sha256(key);
            h.writeArray(msg);
            ignore Blob.toArray(h.sum());
          };
          case (1) {
            let h = Hmac.sha512(key);
            h.writeArray(msg);
            ignore Blob.toArray(h.sum());
          };
          case (_) {};
        };
    };

    Bench.V1(schema, run);
  };
};
