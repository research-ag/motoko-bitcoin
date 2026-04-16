import Array "mo:core/Array";
import Blob "mo:core/Blob";
import Nat16 "mo:core/Nat16";
import Nat32 "mo:core/Nat32";
import Nat64 "mo:core/Nat64";
import Nat8 "mo:core/Nat8";
import Runtime "mo:core/Runtime";
import Text "mo:core/Text";
import VarArray "mo:core/VarArray";

module {
  // All alphanumeric characters except for "0", "I", "O", and "l".
  // prettier-ignore
  private let base58Alphabet : [Nat8] = [
    49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70, 71,
    72, 74, 75, 76, 77, 78, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
    97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 109, 110, 111, 112, 113, 114,
    115, 116, 117, 118, 119, 120, 121, 122
  ];

  // prettier-ignore
  private let mapBase58 : [Nat16] = [
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255, 255, 0,
    1, 2, 3, 4, 5, 6, 7, 8,255,255,255,255,255,255, 255, 9,10,11,12,13,14,15,
    16,255,17,18,19,20,21,255, 22,23,24,25,26,27,28,29,
    30,31,32,255,255,255,255,255, 255,33,34,35,36,37,38,39,
    40,41,42,43,255,44,45,46, 47,48,49,50,51,52,53,54,
    55,56,57,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,
  ];

  // Convert the given Base58 input to Base256.
  public func decode(input_ : Text) : [Nat8] {
    let input = Text.encodeUtf8(input_);
    let inputSize = input.size();
    var pos : Nat = 0;

    // Skip leading spaces.
    while (pos < inputSize and input[pos] == 0x20) {
      pos += 1;
    };

    // Skip and count leading '1's.
    var zeroes : Nat = 0;
    while (pos < inputSize and input[pos] == 0x31) {
      zeroes += 1;
      pos += 1;
    };

    // Find end of base58 payload (before trailing spaces).
    var endPos = pos;
    while (endPos < inputSize and input[endPos] != 0x20) {
      endPos += 1;
    };
    let digitCount : Nat = endPos - pos;

    // Allocate base256 buffer: log(58)/log(256) ≈ 733/1000.
    let size : Nat = digitCount * 733 / 1000 + 1;
    let b256 : [var Nat16] = VarArray.repeat<Nat16>(0x00, size);
    var length : Nat = 0;

    // Process leading remainder digits (digitCount % 8) one at a time.
    let remainder = digitCount % 8;
    var rem : Nat = 0;
    while (rem < remainder) {
      var carry : Nat16 = mapBase58[input[pos].toNat()];
      assert (carry != 0xff);

      var i : Nat = 0;
      var j : Nat = size - 1;
      label inner while (carry != 0 or i < length) {
        carry +%= 58 * b256[j];
        b256[j] := (carry & 0xff);
        carry >>= 8;
        i += 1;
        if (j == 0) break inner;
        j -= 1;
      };

      assert (carry == 0);
      length := i;
      pos += 1;
      rem += 1;
    };

    // Process full batches of 8 digits: b256 = b256 * 58^8 + v.
    // 58^8 = 128_063_081_718_016. Max carry < 2^55, fits in Nat64.
    while (pos < endPos) {
      let d0 : Nat64 = mapBase58[input[pos].toNat()].toNat64();
      let d1 : Nat64 = mapBase58[input[pos + 1].toNat()].toNat64();
      let d2 : Nat64 = mapBase58[input[pos + 2].toNat()].toNat64();
      let d3 : Nat64 = mapBase58[input[pos + 3].toNat()].toNat64();
      let d4 : Nat64 = mapBase58[input[pos + 4].toNat()].toNat64();
      let d5 : Nat64 = mapBase58[input[pos + 5].toNat()].toNat64();
      let d6 : Nat64 = mapBase58[input[pos + 6].toNat()].toNat64();
      let d7 : Nat64 = mapBase58[input[pos + 7].toNat()].toNat64();
      assert (d0 != 0xff and d1 != 0xff and d2 != 0xff and d3 != 0xff
        and d4 != 0xff and d5 != 0xff and d6 != 0xff and d7 != 0xff);

      var carry : Nat64 = (((((((d0 *% 58 +% d1) *% 58 +% d2) *% 58 +% d3) *% 58 +% d4) *% 58 +% d5) *% 58 +% d6) *% 58 +% d7);

      var i : Nat = 0;
      var j : Nat = size - 1;
      label inner while (carry != 0 or i < length) {
        carry +%= 128_063_081_718_016 *% b256[j].toNat64();
        b256[j] := (carry & 0xff).toNat16();
        carry >>= 8;
        i += 1;
        if (j == 0) break inner;
        j -= 1;
      };

      assert (carry == 0);
      length := i;
      pos += 8;
    };

    // Skip trailing spaces.
    while (pos < inputSize and input[pos] == 0x20) {
      pos += 1;
    };

    // Check all input was consumed.
    assert (pos == inputSize);

    // Skip leading zeroes in base256 result.
    var start : Nat = size - length;
    while (start < size and b256[start] == 0) {
      start += 1;
    };

    Array.tabulate<Nat8>(
      zeroes + size - start,
      func(i) {
        if (i < zeroes) 0x00
        else b256[i + start - zeroes].toNat8();
      },
    );
  };

  // Convert the given Base256 input to Base58.
  public func encode(input : [Nat8]) : Text {
    var zeroes : Nat = 0;
    var length : Nat = 0;
    var inputPointer : Nat = 0;

    // Skip & count leading zeroes.
    while (zeroes < input.size() and input[inputPointer] == 0) {
      zeroes += 1;
      inputPointer += 1;
    };

    // Allocate enough space in big-endian base58 representation:
    // log(256) / log(58), rounded up.
    let size : Nat = (input.size() - inputPointer) * 138 / 100 + 1;
    let b58 : [var Nat8] = VarArray.repeat<Nat8>(0, size);

    while (inputPointer < input.size()) {
      var carry : Nat32 = input[inputPointer].toNat16().toNat32();
      var i : Nat = 0;
      // Apply "b58 = b58 * 256 + ch".
      var b58Pointer : Nat = b58.size() - 1;
      label reverseIter while (carry != 0 or i < length) {
        carry += 256 * b58[b58Pointer].toNat16().toNat32();
        b58[b58Pointer] := Nat8.fromNat((carry % 58).toNat());
        carry /= 58;
        i += 1;
        if (b58Pointer == 0) {
          break reverseIter;
        };
        b58Pointer -= 1;
      };
      assert (carry == 0);
      length := i;
      inputPointer += 1;
    };

    // Skip leading zeroes in base58 result.
    var b58Pointer : Nat = size - length;
    while (b58Pointer < b58.size() and b58[b58Pointer] == 0) { b58Pointer += 1 };

    let outputBytes = Array.tabulate<Nat8>(
      zeroes + b58.size() - b58Pointer,
      func(i) {
        if (i < zeroes) {
          0x31 : Nat8;
        } else {
          base58Alphabet[b58[i + b58Pointer - zeroes].toNat()];
        };
      },
    );
    switch (Blob.fromArray(outputBytes).decodeUtf8()) {
      case (?t) t;
      case null Runtime.trap("unreachable");
    };
  };
};
