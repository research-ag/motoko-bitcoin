import Blob "mo:core/Blob";
import Nat "mo:core/Nat";

import { expect; test } "mo:test";

import TestVectors "p2trTestVectors";

for (testCase in TestVectors.testCases().vals()) {
  test(
    "serialized transaction with " # Nat.toText(testCase.numInputs) # " inputs",
    func() {
      let serializedTransaction = testCase.keySpendSignedTransaction().toBytes();

      expect.blob(Blob.fromArray(serializedTransaction)).equal(Blob.fromArray(testCase.expectedSerializedTransaction));
    },
  );
};

for (testCase in TestVectors.testCases().vals()) {
  test(
    "expected transaction id with " # Nat.toText(testCase.numInputs) # " inputs",
    func() {
      let computedTransactionId = testCase.keySpendSignedTransaction().txid();

      expect.blob(Blob.fromArray(computedTransactionId)).equal(Blob.fromArray(testCase.expectedTransactionId));
    },
  );
};
