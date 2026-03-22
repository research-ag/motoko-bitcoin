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
| encode | 1_150 | 41_825 | 314_461 | 1_167_409 | 4_491_286 |
| decode | 1_326 | 37_429 | 308_177 | 1_158_653 | 4_478_257 |


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
| encode | 47_439 | 111_623 | 438_190 | 1_373_728 | 4_861_336 |
| decode | 45_068 | 105_148 | 425_653 | 1_352_538 | 4_823_476 |


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
| bech32  | 30_629 | 42_997 | 87_166 | 127_767 |
| bech32m | 30_693 | 43_078 | 87_200 | 127_843 |


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
| text  | 544_598_943 | 725_478_496 | 909_993_448 |
| array | 544_492_636 | 725_411_159 | 909_916_415 |


**Heap**

|       | depth 3 | depth 4 | depth 5 |
| :---- | ------: | ------: | ------: |
| text  |   272 B |   272 B |   272 B |
| array |   272 B |   272 B |   272 B |


**Garbage Collection**

|       |   depth 3 |   depth 4 |   depth 5 |
| :---- | --------: | --------: | --------: |
| text  |  13.4 MiB | 17.85 MiB | 22.39 MiB |
| array | 13.39 MiB | 17.84 MiB | 22.38 MiB |


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
| build   |   742_560 |   750_662 |
| sighash | 1_370_837 | 1_378_939 |


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
| mulBase  | 10_061_502 | 17_926_668 | 36_232_361 |
| mulPoint | 10_056_468 | 17_922_417 | 36_226_544 |


**Heap**

|          | k small | k medium | k large |
| :------- | ------: | -------: | ------: |
| mulBase  |   272 B |    272 B |   272 B |
| mulPoint |   272 B |    272 B |   272 B |


**Garbage Collection**

|          |    k small |   k medium |    k large |
| :------- | ---------: | ---------: | ---------: |
| mulBase  | 323.25 KiB | 513.52 KiB | 976.96 KiB |
| mulPoint | 322.61 KiB | 512.89 KiB | 976.33 KiB |


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
| DER+verify         |  28_928_546 |  28_833_981 |
| verify (preparsed) | 151_605_837 | 152_875_638 |


**Heap**

|                    | sample 0 | sample 1 |
| :----------------- | -------: | -------: |
| DER+verify         |    272 B |    272 B |
| verify (preparsed) |    272 B |    272 B |


**Garbage Collection**

|                    |  sample 0 |   sample 1 |
| :----------------- | --------: | ---------: |
| DER+verify         | 662.9 KiB | 656.95 KiB |
| verify (preparsed) |  3.79 MiB |   3.82 MiB |


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
| HMAC-SHA256 |  76_236 |  79_730 |  87_405 | 118_887 |
| HMAC-SHA512 | 118_324 | 121_553 | 123_897 | 152_596 |


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
