/// Wallet Import Format (WIF) decoding utilities.
///
/// ```motoko name=import
/// import Wif "mo:bitcoin/bitcoin/Wif";
/// ```

import { type Iter; type Result } "mo:core/Types";

import Base58Check "../Base58Check";
import ByteUtils "../ByteUtils";
import Common "../Common";
import Types "Types";

module {
  /// Textual WIF private key representation.
  ///
  /// A Base58Check string. Mainnet uncompressed keys start with `5`,
  /// compressed mainnet keys start with `K` or `L`; testnet/regtest keys
  /// start with `9` (uncompressed) or `c` (compressed).
  public type WifPrivateKey = Text;

  // Map network to WIF version prefix.
  func _encodeVersion(network : Types.Network) : Nat8 {
    switch (network) {
      case (#Mainnet) {
        0x80;
      };
      case (#Regtest or #Testnet) {
        0xef;
      };
    };
  };

  // Map WIF version prefix to network.
  func decodeVersion(version : Nat8) : ?Types.Network {
    switch (version) {
      case (0x80) {
        ?(#Mainnet);
      };
      case (0xef) {
        ?(#Testnet);
      };
      case _ {
        null;
      };
    };
  };

  /// Decodes a WIF key into network, scalar value, and compression flag.
  ///
  /// Returns `#err(message)` when:
  /// - `key` is not valid Base58Check (alphabet error or checksum mismatch)
  ///   — `"Could not base58 decode key."`,
  /// - the trailing byte is present but not `0x01` —
  ///   `"Invalid compression flag."`,
  /// - the payload is not exactly `version || 32-byte key [|| 0x01]` —
  ///   `"Invalid key format."`,
  /// - the version byte is not `0x80` (mainnet) or `0xef` (testnet/regtest)
  ///   — `"Unknown network version."`.
  ///
  /// Traps if the Base58 payload is shorter than 4 bytes (inherited from
  /// `Base58Check.decode`).
  // Decode WIF private key to extract network, private key,
  // and compression flag.
  public func decode(key : WifPrivateKey) : Result<Types.BitcoinPrivateKey, Text> {
    let decoded : Iter<Nat8> = switch (Base58Check.decode(key)) {
      case (?b58decoded) {
        b58decoded.values();
      };
      case _ {
        return #err("Could not base58 decode key.");
      };
    };
    // Split into version || data || compressed.
    let (version, data, compressed) : (Nat8, [Nat8], Bool) = switch (
      decoded.next(),
      ByteUtils.read(decoded, 32, false),
      decoded.next(),
      decoded.next(),
    ) {
      case (?version, ?data, ?(0x01), null) { (version, data, true) };
      case (?version, ?data, null, null) { (version, data, false) };
      case (_, _, ?(_compressionFlag), _) {
        return #err("Invalid compression flag.");
      };
      case _ {
        return #err("Invalid key format.");
      };
    };

    let network : Types.Network = switch (decodeVersion(version)) {
      case (?network) {
        network;
      };
      case _ {
        return #err("Unknown network version.");
      };
    };

    return #ok({
      network = network;
      key = Common.readBE256(data, 0);
      compressedPublicKey = compressed;
    });
  };
};
