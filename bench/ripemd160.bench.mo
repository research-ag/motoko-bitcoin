import Array "mo:core/Array";
import Nat8 "mo:core/Nat8";

import Bench "mo:bench-helper";

import Ripemd160 "../src/Ripemd160";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "RIPEMD-160";
      description = "RIPEMD-160 one-shot hash across message sizes, plus incremental digest";
      rows = ["hash (one-shot)", "Digest (incremental, 64-byte chunks)"];
      cols = ["len 0", "len 32", "len 64", "len 256", "len 1024"];
    };

    let datas : [[Nat8]] = [
      [],
      Array.tabulate<Nat8>(32, func i { Nat8.fromNat((i * 3 + 1) % 256) }),
      Array.tabulate<Nat8>(64, func i { Nat8.fromNat((i * 7 + 5) % 256) }),
      Array.tabulate<Nat8>(256, func i { Nat8.fromNat((i * 11 + 13) % 256) }),
      Array.tabulate<Nat8>(1024, func i { Nat8.fromNat((i * 17 + 9) % 256) }),
    ];

    // Pre-split each input into 64-byte chunks for the incremental row.
    let chunkedDatas : [[[Nat8]]] = Array.tabulate<[[Nat8]]>(
      datas.size(),
      func(ci) {
        let data = datas[ci];
        let total = data.size();
        if (total == 0) {
          [];
        } else {
          let nChunks = (total + 63) / 64;
          Array.tabulate<[Nat8]>(
            nChunks,
            func(k) {
              let start = k * 64;
              let end = if (start + 64 < total) { start + 64 } else { total };
              Array.tabulate<Nat8>(end - start, func(j) { data[start + j] });
            },
          );
        };
      },
    );

    func run(ri : Nat, ci : Nat) {
      switch (ri) {
        case (0) {
          ignore Ripemd160.hash(datas[ci]);
        };
        case (1) {
          let d = Ripemd160.Digest();
          for (chunk in chunkedDatas[ci].values()) {
            d.write(chunk);
          };
          ignore d.sum();
        };
        case (_) {};
      };
    };

    Bench.V1(schema, run);
  };
};
