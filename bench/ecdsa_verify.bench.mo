import Array "mo:core/Array";
import Blob "mo:core/Blob";
import Text "mo:core/Text";
import VarArray "mo:core/VarArray";

import Bench "mo:bench-helper";

import Curves "../src/ec/Curves";
import Der "../src/ecdsa/Der";
import Ecdsa "../src/ecdsa/Ecdsa";
import PublicKey "../src/ecdsa/Publickey";

module {

  // Minimal hex decoder (lowercase/uppercase supported)
  func toNibble(c : Nat8) : Nat8 {
    if (c >= 0x30 and c <= 0x39) { return c - 0x30 };
    let cl = if (c >= 0x41 and c <= 0x5a) c + 32 else c; // upper->lower
    if (cl >= 0x61 and cl <= 0x66) { return cl - 0x61 + 10 };
    0;
  };
  public func decode(t : Text) : [Nat8] {
    let b = Blob.toArray(Text.encodeUtf8(t));
    let n = b.size();
    if (n == 0) return [];
    let out = VarArray.repeat<Nat8>(0, (n + 1) / 2);
    var oi = 0;
    var i = 0;
    if (n % 2 == 1) {
      out[oi] := toNibble(b[i]);
      oi += 1;
      i += 1;
    };
    while (i + 1 < n) {
      let hi = toNibble(b[i]);
      let lo = toNibble(b[i + 1]);
      out[oi] := (hi << 4) + lo;
      oi += 1;
      i += 2;
    };
    Array.fromVarArray(out);
  };

  let samples = [
    {
      key = "0387d82042d93447008dfe2af762068a1e53ff394a5bf8f68a045fa642b99ea5d1";
      sig = "30440220112233445566778899aabbccddeeff00112233445566778899aabbccddee0220112233445566778899aabbccddeeff00112233445566778899aabbccddef";
      msg = "48656c6c6f2c206563647361212121";
    },
    {
      key = "02ad5efbc62010894e5219f2709fa5a1007b51fdf370c1f00cc0ee0425e41dd5cd";
      sig = "3045022100dff1d77f2a671c5f962f7a9a7f1f8f5b9c3c1b6a2f29905f3b1c3a50b5bc2d7c02206b12d606a26f6f6b8b3e6b3a4f1a1b0c3d4e5f6a7b8c9dad0e0f1a2b3c4d5";
      msg = "000102030405060708090a0b0c0d0e0f";
    },
  ];

  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "ECDSA verify: DER vs raw (DER decode cost)";
      description = "Compare verifying using DER decode per run vs reusing parsed signature";
      rows = ["DER+verify", "verify (preparsed)"];
      cols = ["sample 0", "sample 1"];
    };

    // Pre-parse signatures and keys
    let parsed = Array.tabulate<(Ecdsa.PublicKey, Ecdsa.Signature)>(
      samples.size(),
      func i {
        let s = samples[i];
        let keyBytes = decode(s.key);
        let sigBytes = decode(s.sig);
        let pk = switch (PublicKey.decode(#sec1(keyBytes, Curves.secp256k1))) {
          case (#ok v) v;
          case _ {
            let curve = Curves.secp256k1;
            {
              coords = { x = curve.Fp(curve.gx); y = curve.Fp(curve.gy) };
              curve = curve;
            };
          };
        };
        let sig = switch (Der.decodeSignature(Blob.fromArray(sigBytes))) {
          case (#ok v) v;
          case _ { { r = 1; s = 1 } };
        };
        (pk, sig);
      },
    );

    func run(ri : Nat, ci : Nat) {
      let s = samples[ci];
      let msgBytes = decode(s.msg);
      switch (ri) {
        case (0) {
          let keyBytes = decode(s.key);
          let sigBytes = decode(s.sig);
          switch (PublicKey.decode(#sec1(keyBytes, Curves.secp256k1)), Der.decodeSignature(Blob.fromArray(sigBytes))) {
            case (#ok pk, #ok sig) { ignore Ecdsa.verify(sig, pk, msgBytes) };
            case _ {};
          };
        };
        case (1) {
          let (pk, sig) = parsed[ci];
          ignore Ecdsa.verify(sig, pk, msgBytes);
        };
        case (_) {};
      };
    };

    Bench.V1(schema, run);
  };
};
