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

|        | len 0 | len 10 |  len 32 |  len 64 |   len 128 |
| :----- | ----: | -----: | ------: | ------: | --------: |
| encode | 1_182 | 26_059 | 210_836 | 800_098 | 3_114_843 |
| decode | 1_316 | 26_644 | 213_296 | 805_615 | 3_127_486 |


**Heap**

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|        | len 0 | len 10 | len 32 |   len 64 |  len 128 |
| :----- | ----: | -----: | -----: | -------: | -------: |
| encode | 372 B |  508 B |  808 B | 1.22 KiB | 2.07 KiB |
| decode | 424 B |  500 B |  676 B |    932 B | 1.41 KiB |


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

|        |  len 0 | len 10 |  len 32 |  len 64 |   len 128 |
| :----- | -----: | -----: | ------: | ------: | --------: |
| encode | 41_565 | 84_651 | 309_351 | 961_324 | 3_398_416 |
| decode | 42_174 | 83_950 | 306_560 | 955_606 | 3_388_120 |


**Heap**

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|        |    len 0 |   len 10 |   len 32 |   len 64 |  len 128 |
| :----- | -------: | -------: | -------: | -------: | -------: |
| encode | 3.91 KiB | 4.16 KiB | 4.63 KiB |  5.3 KiB | 6.66 KiB |
| decode | 3.94 KiB | 4.05 KiB | 4.31 KiB | 4.69 KiB | 5.44 KiB |


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
| encode bech32  | 11_982 | 15_543 | 25_974 | 34_330 |
| encode bech32m | 12_014 | 15_575 | 26_006 | 34_362 |
| decode bech32  | 10_694 | 15_066 | 27_559 | 37_597 |
| decode bech32m | 10_768 | 15_164 | 27_633 | 37_659 |


**Heap**

|                | len 0 | len 5 | len 20 | len 32 |
| :------------- | ----: | ----: | -----: | -----: |
| encode bech32  | 272 B | 272 B |  272 B |  272 B |
| encode bech32m | 272 B | 272 B |  272 B |  272 B |
| decode bech32  | 272 B | 272 B |  272 B |  272 B |
| decode bech32m | 272 B | 272 B |  272 B |  272 B |


**Garbage Collection**

|                | len 0 | len 5 |   len 20 |   len 32 |
| :------------- | ----: | ----: | -------: | -------: |
| encode bech32  | 840 B | 908 B | 1.09 KiB | 1.26 KiB |
| encode bech32m | 840 B | 908 B | 1.09 KiB | 1.26 KiB |
| decode bech32  | 804 B | 932 B |  1.2 KiB | 1.44 KiB |
| decode bech32m | 804 B | 932 B |  1.2 KiB | 1.44 KiB |


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
| text  | 544_358_509 | 725_157_063 | 909_593_270 |
| array | 544_254_818 | 725_092_034 | 909_518_890 |


**Heap**

|       | depth 3 | depth 4 | depth 5 |
| :---- | ------: | ------: | ------: |
| text  |   272 B |   272 B |   272 B |
| array |   272 B |   272 B |   272 B |


**Garbage Collection**

|       |   depth 3 |   depth 4 |   depth 5 |
| :---- | --------: | --------: | --------: |
| text  | 13.37 MiB | 17.81 MiB | 22.34 MiB |
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
| build   |   574_019 |   582_087 |
| sighash | 1_127_651 | 1_135_719 |


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
| DER+verify         | 307_343_230 | 306_581_317 |
| verify (preparsed) | 306_815_024 | 306_097_902 |


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
| encode |  146_027 |  204_067 |  204_039 |  145_963 |  204_111 |  204_099 |
| decode |   70_224 |   99_696 |   99_687 |   70_192 |   99_736 |   99_711 |


**Heap**

|        | bc v0/20 | bc v0/32 | bc v1/32 | tb v0/20 | tb v0/32 | tb v1/32 |
| :----- | -------: | -------: | -------: | -------: | -------: | -------: |
| encode |    272 B |    272 B |    272 B |    272 B |    272 B |    272 B |
| decode |    272 B |    272 B |    272 B |    272 B |    272 B |    272 B |


**Garbage Collection**

|        | bc v0/20 | bc v0/32 | bc v1/32 | tb v0/20 | tb v0/32 | tb v1/32 |
| :----- | -------: | -------: | -------: | -------: | -------: | -------: |
| encode | 4.06 KiB |    5 KiB |    5 KiB | 4.06 KiB |    5 KiB |    5 KiB |
| decode | 2.18 KiB | 2.68 KiB | 2.68 KiB | 2.18 KiB | 2.68 KiB | 2.68 KiB |


</details>
