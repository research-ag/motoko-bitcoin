import Bitcoin "../src/bitcoin/Bitcoin";
import P2pkh "../src/bitcoin/P2pkh";
import Types "../src/bitcoin/Types";
import Transaction "../src/bitcoin/Transaction";
import Witness "../src/bitcoin/Witness";
import Bench "mo:bench";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";

module {
  // Simple fixtures
  let testnetP2pkh1 : Text = "mrFF91kpuRbivucowsY512fDnYt6BWrvx9";
  let testnetP2pkh2 : Text = "mnNcaVkC35ezZSgvn8fhXEa9QTHSUtPfzQ";

  func mkOutPoint(n : Nat32) : Types.OutPoint {
    // 32-byte txid filled with n
    let txid = Blob.fromArray(Array.tabulate<Nat8>(32, func i { Nat8.fromNat(Nat32.toNat(n & 0xff)) }));
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

  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    bench.name("Bitcoin tx: build vs sighash");
    bench.description("Compare building a simple tx vs computing P2PKH sighash");

    bench.rows(["build", "sighash"]);
    bench.cols(["2 utxos", "4 utxos"]);

    bench.runner(
      func(row : Text, col : Text) {
        let utxoCount = if (col == "2 utxos") 2 else 4;
        let utxos = mkUtxos(utxoCount);
        let changeAddr : Types.Address = #p2pkh(testnetP2pkh1);
        let destinations : [(Types.Address, Types.Satoshi)] = [
          (#p2pkh(testnetP2pkh2), 100_000),
          (#p2pkh(testnetP2pkh1), 200_000),
        ];
        switch (row) {
          case ("build") {
            ignore Bitcoin.buildTransaction(1, utxos, destinations, changeAddr, 1_000);
          };
          case ("sighash") {
            let tx = switch (Bitcoin.buildTransaction(1, utxos, destinations, changeAddr, 1_000)) {
              case (#ok t) t;
              case (#err _) Transaction.Transaction(1, [], [], Array.init<Witness.Witness>(0, Witness.EMPTY_WITNESS), 0);
            };
            let script = switch (P2pkh.makeScript(testnetP2pkh2)) {
              case (#ok s) s;
              case (#err _) [];
            };
            var i : Nat = 0;
            while (i < tx.txInputs.size()) {
              ignore tx.createP2pkhSignatureHash(script, Nat32.fromNat(i), Types.SIGHASH_ALL);
              i += 1;
            };
          };
          case (_) {};
        };
      }
    );

    bench;
  };
};
