import Array "mo:core/Array";
import Blob "mo:core/Blob";
import Nat32 "mo:core/Nat32";
import Nat8 "mo:core/Nat8";
import Runtime "mo:core/Runtime";

import Bench "mo:bench-helper";

import Bitcoin "../src/bitcoin/Bitcoin";
import P2pkh "../src/bitcoin/P2pkh";
import Types "../src/bitcoin/Types";

module {
  // Simple fixtures
  let testnetP2pkh1 : Text = "mrFF91kpuRbivucowsY512fDnYt6BWrvx9";
  let testnetP2pkh2 : Text = "mnNcaVkC35ezZSgvn8fhXEa9QTHSUtPfzQ";

  func mkOutPoint(n : Nat32) : Types.OutPoint {
    // 32-byte txid filled with n
    let txid = Blob.fromArray(Array.tabulate<Nat8>(32, func _ { Nat8.fromNat(Nat32.toNat(n & 0xff)) }));
    { txid = txid; vout = n };
  };

  func mkUtxos(count : Nat) : [Types.Utxo] {
    Array.tabulate<Types.Utxo>(
      count,
      func i {
        {
          outpoint = mkOutPoint(Nat32.fromNat(i));
          value = 50_000_000; /* 0.5 BTC (in sats) */
          height = 1_000 + Nat32.fromNat(i);
        };
      },
    );
  };

  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "Bitcoin tx: build vs sighash";
      description = "Compare building a simple tx vs computing P2PKH sighash";
      rows = ["build", "sighash"];
      cols = ["2 utxos", "4 utxos"];
    };

    func run(ri : Nat, ci : Nat) {
      let utxoCount = if (ci == 0) 2 else 4;
      let utxos = mkUtxos(utxoCount);
      let changeAddr : Types.Address = #p2pkh(testnetP2pkh1);
      let destinations : [(Types.Address, Types.Satoshi)] = [
        (#p2pkh(testnetP2pkh2), 100_000),
        (#p2pkh(testnetP2pkh1), 200_000),
      ];
      switch (ri) {
        case (0) {
          ignore Bitcoin.buildTransaction(1, utxos, destinations, changeAddr, 1_000);
        };
        case (1) {
          let tx = switch (Bitcoin.buildTransaction(1, utxos, destinations, changeAddr, 1_000)) {
            case (#ok t) t;
            case (#err _) Runtime.trap("buildTransaction failed");
          };
          let script = switch (P2pkh.makeScript(testnetP2pkh2)) {
            case (#ok s) s;
            case (#err _) Runtime.trap("buildTransaction failed");
          };
          var i : Nat = 0;
          while (i < tx.txInputs.size()) {
            ignore tx.createP2pkhSignatureHash(script, Nat32.fromNat(i), Types.SIGHASH_ALL);
            i += 1;
          };
        };
        case (_) {};
      };
    };

    Bench.V1(schema, run);
  };
};
