# Benchmark Results



<details>

<summary>bench/base58.bench.mo $({\color{gray}0\%})$</summary>

### Base58 encode/decode

_Benchmark Base58 encode/decode across input sizes_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|        | len 0 | len 10 |  len 32 |    len 64 |   len 128 |
| :----- | ----: | -----: | ------: | --------: | --------: |
| encode | 1_141 | 40_999 | 307_973 | 1_143_229 | 4_398_191 |
| decode | 1_317 | 36_140 | 300_172 | 1_131_408 | 4_379_042 |


**Heap**

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|        | len 0 | len 10 |   len 32 |   len 64 |  len 128 |
| :----- | ----: | -----: | -------: | -------: | -------: |
| encode | 420 B |  860 B |  1.9 KiB | 3.45 KiB | 6.51 KiB |
| decode | 424 B |  580 B | 1.21 KiB | 2.14 KiB |    4 KiB |


</details>

<details>

<summary>bench/base58check.bench.mo $({\color{gray}0\%})$</summary>

### Base58Check encode/decode

_Benchmark Base58Check encode/decode across input sizes_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|        |  len 0 |  len 10 |  len 32 |    len 64 |   len 128 |
| :----- | -----: | ------: | ------: | --------: | --------: |
| encode | 46_728 | 109_579 | 429_304 | 1_345_451 | 4_760_683 |
| decode | 44_062 | 102_456 | 415_285 | 1_321_592 | 4_717_698 |


**Heap**

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|        |    len 0 |   len 10 |   len 32 |   len 64 |   len 128 |
| :----- | -------: | -------: | -------: | -------: | --------: |
| encode | 4.08 KiB | 4.66 KiB | 5.89 KiB | 7.66 KiB | 11.25 KiB |
| decode | 3.94 KiB | 4.23 KiB | 4.95 KiB |    6 KiB |  8.13 KiB |


</details>

<details>

<summary>bench/bech32.bench.mo $({\color{gray}0\%})$</summary>

### Bech32 vs Bech32m (encode)

_Compare Bech32 and Bech32m encoding across sizes_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|                |  len 0 |  len 5 | len 20 | len 32 |
| :------------- | -----: | -----: | -----: | -----: |
| encode bech32  | 18_281 | 24_057 | 41_345 | 55_229 |
| encode bech32m | 18_313 | 24_089 | 41_377 | 55_261 |
| decode bech32  | 11_357 | 17_417 | 35_032 | 49_156 |
| decode bech32m | 11_431 | 17_515 | 35_106 | 49_218 |


**Heap**

|                | len 0 | len 5 | len 20 | len 32 |
| :------------- | ----: | ----: | -----: | -----: |
| encode bech32  | 272 B | 272 B |  272 B |  272 B |
| encode bech32m | 272 B | 272 B |  272 B |  272 B |
| decode bech32  | 272 B | 272 B |  272 B |  272 B |
| decode bech32m | 272 B | 272 B |  272 B |  272 B |


**Garbage Collection**

|                |    len 0 |    len 5 |   len 20 |   len 32 |
| :------------- | -------: | -------: | -------: | -------: |
| encode bech32  | 1.16 KiB | 1.36 KiB | 1.94 KiB | 2.41 KiB |
| encode bech32m | 1.16 KiB | 1.36 KiB | 1.94 KiB | 2.41 KiB |
| decode bech32  |    824 B |    956 B | 1.24 KiB | 1.49 KiB |
| decode bech32m |    824 B |    956 B | 1.24 KiB | 1.49 KiB |


</details>

<details>

<summary>bench/bip32.bench.mo $({\color{gray}0\%})$</summary>

### BIP32 derivePath: text vs array

_Compare path representations for public derivation_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|       |     depth 3 |     depth 4 |     depth 5 |
| :---- | ----------: | ----------: | ----------: |
| text  | 544_378_130 | 725_185_392 | 909_626_770 |
| array | 544_277_189 | 725_124_163 | 909_557_483 |


**Heap**

|       | depth 3 | depth 4 | depth 5 |
| :---- | ------: | ------: | ------: |
| text  |   272 B |   272 B |   272 B |
| array |   272 B |   272 B |   272 B |


**Garbage Collection**

|       |   depth 3 |   depth 4 |   depth 5 |
| :---- | --------: | --------: | --------: |
| text  | 13.37 MiB | 17.81 MiB | 22.35 MiB |
| array | 13.37 MiB | 17.81 MiB | 22.34 MiB |


</details>

<details>

<summary>bench/bitcoin_tx.bench.mo $({\color{gray}0\%})$</summary>

### Bitcoin tx: build vs sighash

_Compare building a simple tx vs computing P2PKH sighash_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|         |   2 utxos |   4 utxos |
| :------ | --------: | --------: |
| build   |   723_425 |   731_493 |
| sighash | 1_326_866 | 1_334_934 |


**Heap**

|         | 2 utxos | 4 utxos |
| :------ | ------: | ------: |
| build   |   272 B |   272 B |
| sighash |   272 B |   272 B |


**Garbage Collection**

|         |   2 utxos |   4 utxos |
| :------ | --------: | --------: |
| build   | 14.39 KiB | 14.86 KiB |
| sighash | 30.39 KiB | 30.86 KiB |


</details>

<details>

<summary>bench/ec_arith.bench.mo $({\color{gray}0\%})$</summary>

### EC scalar mul: base vs arbitrary point

_Compare scalar multiplication using generator vs arbitrary point_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|          |    k small |   k medium |    k large |
| :------- | ---------: | ---------: | ---------: |
| mulBase  | 10_058_889 | 17_922_240 | 36_223_859 |
| mulPoint | 10_053_858 | 17_917_929 | 36_218_108 |


**Heap**

|          | k small | k medium | k large |
| :------- | ------: | -------: | ------: |
| mulBase  |   272 B |    272 B |   272 B |
| mulPoint |   272 B |    272 B |   272 B |


**Garbage Collection**

|          |    k small |   k medium |    k large |
| :------- | ---------: | ---------: | ---------: |
| mulBase  | 322.99 KiB | 513.06 KiB | 976.04 KiB |
| mulPoint | 322.36 KiB | 512.43 KiB |  975.4 KiB |


</details>

<details>

<summary>bench/ecdsa_verify.bench.mo $({\color{gray}0\%})$</summary>

### ECDSA verify: DER vs raw (DER decode cost)

_Compare verifying using DER decode per run vs reusing parsed signature_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|                    |    sample 0 |    sample 1 |
| :----------------- | ----------: | ----------: |
| DER+verify         | 307_363_824 | 306_601_848 |
| verify (preparsed) | 306_817_775 | 306_100_653 |


**Heap**

|                    | sample 0 | sample 1 |
| :----------------- | -------: | -------: |
| DER+verify         |    272 B |    272 B |
| verify (preparsed) |    272 B |    272 B |


**Garbage Collection**

|                    | sample 0 | sample 1 |
| :----------------- | -------: | -------: |
| DER+verify         | 7.69 MiB | 7.66 MiB |
| verify (preparsed) | 7.67 MiB | 7.65 MiB |


</details>

<details>

<summary>bench/hash_hmac.bench.mo $({\color{gray}0\%})$</summary>

### HMAC: SHA256 vs SHA512

_Compare HMAC-SHA256 and HMAC-SHA512 across message sizes_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|             |   len 0 |  len 32 |  len 64 | len 256 |
| :---------- | ------: | ------: | ------: | ------: |
| HMAC-SHA256 |  75_747 |  79_241 |  86_916 | 118_398 |
| HMAC-SHA512 | 118_027 | 121_256 | 123_600 | 152_299 |


**Heap**

|             | len 0 | len 32 | len 64 | len 256 |
| :---------- | ----: | -----: | -----: | ------: |
| HMAC-SHA256 | 272 B |  272 B |  272 B |   272 B |
| HMAC-SHA512 | 272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|             |    len 0 |   len 32 |   len 64 |  len 256 |
| :---------- | -------: | -------: | -------: | -------: |
| HMAC-SHA256 | 4.73 KiB | 4.73 KiB | 4.73 KiB | 4.73 KiB |
| HMAC-SHA512 | 6.78 KiB | 6.92 KiB | 6.97 KiB | 6.88 KiB |


</details>

<details>

<summary>bench/segwit.bench.mo $({\color{gray}0\%})$</summary>

### SegWit (address encode/decode)

_Benchmark SegWit Bech32/Bech32m address encode/decode for common versions and program lengths_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|        | bc v0/20 | bc v0/32 | bc v1/32 | tb v0/20 | tb v0/32 | tb v1/32 |
| :----- | -------: | -------: | -------: | -------: | -------: | -------: |
| encode |  179_826 |  254_100 |  254_072 |  179_762 |  254_144 |  254_132 |
| decode |   82_461 |  118_963 |  118_954 |   82_429 |  119_003 |  118_978 |


**Heap**

|        | bc v0/20 | bc v0/32 | bc v1/32 | tb v0/20 | tb v0/32 | tb v1/32 |
| :----- | -------: | -------: | -------: | -------: | -------: | -------: |
| encode |    272 B |    272 B |    272 B |    272 B |    272 B |    272 B |
| decode |    272 B |    272 B |    272 B |    272 B |    272 B |    272 B |


**Garbage Collection**

|        | bc v0/20 | bc v0/32 | bc v1/32 | tb v0/20 | tb v0/32 | tb v1/32 |
| :----- | -------: | -------: | -------: | -------: | -------: | -------: |
| encode | 5.29 KiB | 6.76 KiB | 6.76 KiB | 5.29 KiB | 6.76 KiB | 6.76 KiB |
| decode | 2.23 KiB | 2.75 KiB | 2.75 KiB | 2.23 KiB | 2.75 KiB | 2.75 KiB |


</details>
