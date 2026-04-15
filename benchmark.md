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
| encode | 1_140 | 40_998 | 307_972 | 1_143_228 | 4_398_190 |
| decode | 1_316 | 36_139 | 300_171 | 1_131_407 | 4_379_041 |


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
| encode | 46_726 | 109_577 | 429_302 | 1_345_449 | 4_760_681 |
| decode | 44_061 | 102_455 | 415_284 | 1_321_591 | 4_717_697 |


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

### Bech32 vs Bech32m

_Compare Bech32 and Bech32m encoding across sizes_


Instructions: ${\color{gray}0\\%}$
Heap: ${\color{gray}0\\%}$
Stable Memory: ${\color{gray}0\\%}$
Garbage Collection: ${\color{gray}0\\%}$


**Instructions**

|                |  len 0 |  len 5 | len 20 | len 32 |
| :------------- | -----: | -----: | -----: | -----: |
| encode bech32  | 18_277 | 24_053 | 41_341 | 55_225 |
| encode bech32m | 18_309 | 24_085 | 41_373 | 55_257 |
| decode bech32  | 11_354 | 17_414 | 35_029 | 49_153 |
| decode bech32m | 11_428 | 17_512 | 35_103 | 49_215 |


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
| text  | 544_380_979 | 725_189_387 | 909_632_280 |
| array | 544_277_099 | 725_124_043 | 909_557_333 |


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
| build   |   723_422 |   731_490 |
| sighash | 1_326_847 | 1_334_915 |


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
| mulBase  | 10_058_884 | 17_922_235 | 36_223_854 |
| mulPoint | 10_053_853 | 17_917_924 | 36_218_103 |


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
| DER+verify         | 307_363_770 | 306_601_794 |
| verify (preparsed) | 306_817_755 | 306_100_633 |


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
| HMAC-SHA256 |  75_746 |  79_240 |  86_915 | 118_397 |
| HMAC-SHA512 | 118_026 | 121_255 | 123_599 | 152_298 |


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
| encode |  179_819 |  254_093 |  254_065 |  179_755 |  254_137 |  254_125 |
| decode |   82_458 |  118_960 |  118_951 |   82_426 |  119_000 |  118_975 |


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
