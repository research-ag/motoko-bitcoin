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
| encode | 1_141 | 41_064 | 308_188 | 1_143_664 | 4_399_061 |
| decode | 1_317 | 36_345 | 300_827 | 1_132_723 | 4_381_662 |


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
| encode | 46_758 | 109_774 | 429_869 | 1_346_551 | 4_762_863 |
| decode | 44_224 | 102_813 | 416_092 | 1_323_044 | 4_720_470 |


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

|         |  len 0 |  len 5 | len 20 |  len 32 |
| :------ | -----: | -----: | -----: | ------: |
| bech32  | 29_626 | 41_589 | 84_294 | 123_548 |
| bech32m | 29_689 | 41_668 | 84_329 | 123_623 |


**Heap**

|         | len 0 | len 5 | len 20 | len 32 |
| :------ | ----: | ----: | -----: | -----: |
| bech32  | 272 B | 272 B |  272 B |  272 B |
| bech32m | 272 B | 272 B |  272 B |  272 B |


**Garbage Collection**

|         |    len 0 | len 5 |   len 20 |   len 32 |
| :------ | -------: | ----: | -------: | -------: |
| bech32  | 1.68 KiB | 2 KiB | 3.09 KiB | 4.11 KiB |
| bech32m | 1.68 KiB | 2 KiB | 3.09 KiB | 4.11 KiB |


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
| text  | 544_400_064 | 725_214_344 | 909_663_341 |
| array | 544_294_228 | 725_146_945 | 909_586_028 |


**Heap**

|       | depth 3 | depth 4 | depth 5 |
| :---- | ------: | ------: | ------: |
| text  |   272 B |   272 B |   272 B |
| array |   272 B |   272 B |   272 B |


**Garbage Collection**

|       |   depth 3 |   depth 4 |   depth 5 |
| :---- | --------: | --------: | --------: |
| text  | 13.37 MiB | 17.82 MiB | 22.35 MiB |
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
| build   |   725_699 |   733_767 |
| sighash | 1_334_748 | 1_342_816 |


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
| mulBase  | 10_059_083 | 17_922_564 | 36_224_483 |
| mulPoint | 10_054_052 | 17_918_253 | 36_218_732 |


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
| DER+verify         |  28_894_974 |  28_801_023 |
| verify (preparsed) | 151_573_382 | 152_842_861 |


**Heap**

|                    | sample 0 | sample 1 |
| :----------------- | -------: | -------: |
| DER+verify         |    272 B |    272 B |
| verify (preparsed) |    272 B |    272 B |


**Garbage Collection**

|                    |   sample 0 |   sample 1 |
| :----------------- | ---------: | ---------: |
| DER+verify         | 658.66 KiB | 652.77 KiB |
| verify (preparsed) |   3.79 MiB |   3.82 MiB |


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
| encode |  180_839 |  255_701 |  255_657 |  180_791 |  255_761 |  255_749 |
| decode |   83_274 |  120_204 |  120_179 |   83_258 |  120_260 |  120_235 |


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
