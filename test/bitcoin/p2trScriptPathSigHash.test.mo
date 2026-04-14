import Blob "mo:core/Blob";
import Nat "mo:core/Nat";

import { expect; test } "mo:test";

import TestVectors "p2trTestVectors";

for (testCase in TestVectors.testCases().vals()) {
  test(
    Nat.toText(testCase.numInputs) # " inputs",
    func() {
      assert testCase.expectedScriptSpendSigHashes.size() == testCase.numInputs;

      let computedSigHashes = testCase.scriptSpendSigHashes();
      assert computedSigHashes.size() == testCase.numInputs;

      for (inputIndex in computedSigHashes.keys()) {
        expect.blob(Blob.fromArray(computedSigHashes[inputIndex])).equal(Blob.fromArray(testCase.expectedScriptSpendSigHashes[inputIndex]));
      };
    },
  );
};
