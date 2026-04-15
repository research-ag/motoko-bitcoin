import Array "mo:core/Array";
import Blob "mo:core/Blob";
import Char "mo:core/Char";
import Nat16 "mo:core/Nat16";
import Nat32 "mo:core/Nat32";
import Nat8 "mo:core/Nat8";
import Runtime "mo:core/Runtime";
import Text "mo:core/Text";
import { type Iter } "mo:core/Types";
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
  private let mapBase58 : [Nat8] = [
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
  public func decode(input : Text) : [Nat8] {
    let inputIter : Iter<Char> = input.chars();
    var current : ?Char = inputIter.next();
    var spaces : Nat = 0;

    // Skip leading spaces
    label l loop {
      switch (current) {
        case (?' ') {
          spaces := spaces + 1;
        };
        case (_) {
          break l;
        };
      };
      current := inputIter.next();
    };

    // Skip and count leading '1's.
    var zeroes : Nat = 0;
    var length : Nat = 0;

    label l loop {
      switch (current) {
        case (?'1') {
          zeroes := zeroes + 1;
        };
        case (_) {
          break l;
        };
      };
      current := inputIter.next();
    };

    // Compute how many bytes are needed for the Base256 representation. We
    // need log(58) / log(256) of one byte to represent a Base58 digit in
    // Base256, which is approximately 733 / 1000. The input size is multiplied
    // by this value and rounded up to get the total Base256 required size.
    let size : Nat = (input.size() - zeroes - spaces) * 733 / 1000 + 1;
    let b256 : [var Nat8] = VarArray.repeat<Nat8>(0x00, size);

    label l loop {
      switch (current) {
        case (?' ') {
          break l;
        };
        case (null) {
          break l;
        };
        case (?value) {
          var carry : Nat32 = mapBase58[value.toNat32().toNat()].toNat16().toNat32();
          assert (carry != 0xff);

          var i : Nat = 0;
          var b256Pointer : Nat = b256.size() - 1;
          label reverseIter while (carry != 0 or i < length) {

            carry += 58 * b256[b256Pointer].toNat16().toNat32();
            b256[b256Pointer] := Nat8.fromNat((carry % 256).toNat());
            carry /= 256;
            i += 1;

            if (b256Pointer == 0) {
              break reverseIter;
            };
            b256Pointer -= 1;
          };

          assert (carry == 0);
          length := i;
        };
      };
      current := inputIter.next();
    };

    // Skip trailing spaces.
    label l loop {
      switch (current) {
        case (?' ') {};
        case (_) {
          break l;
        };
      };
      current := inputIter.next();
    };

    // Check all input was consumed.
    assert (current == null);

    // Skip leading zeroes in base256 result.
    var b256Pointer : Nat = size - length;
    while (b256Pointer < b256.size() and b256[b256Pointer] == 0) {
      b256Pointer += 1;
    };

    let output = Array.tabulate<Nat8>(
      zeroes + b256.size() - b256Pointer,
      func(i) {
        if (i < zeroes) {
          0x00;
        } else {
          b256[i + b256Pointer - zeroes];
        };
      },
    );

    output;
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
