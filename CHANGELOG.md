# Motoko `bitcoin` changelog

## 1.0.0

* Migrate code from `base` to `core`
* *Breaking:* Remove redundant `toBytes` function in `bitcoin/TxOutput.mo` (use class method instead)
* *Breaking:* Add length assertions inside `Bech32.encode()`
* Bugfix: lowercase character range in `Bech32.mo` was incorrect


## 0.1.1

* Fix tests and formatting.
* Add `CODEOWNERS`.
* Update dependencies: `base`.