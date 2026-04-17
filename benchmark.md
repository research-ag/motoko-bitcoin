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

|        | len 0 | len 10 | len 32 |  len 64 | len 128 |
| :----- | ----: | -----: | -----: | ------: | ------: |
| encode | 1_202 | 10_499 | 44_328 | 127_595 | 429_648 |
| decode | 1_092 | 10_192 | 34_994 | 106_525 | 347_882 |


**Heap**

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|        | len 0 | len 10 | len 32 |   len 64 |  len 128 |
| :----- | ----: | -----: | -----: | -------: | -------: |
| encode | 364 B |  500 B |  800 B | 1.21 KiB | 2.07 KiB |
| decode | 348 B |  424 B |  600 B |    856 B | 1.34 KiB |


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

|        |  len 0 | len 10 | len 32 |  len 64 | len 128 |
| :----- | -----: | -----: | -----: | ------: | ------: |
| encode | 40_628 | 52_103 | 96_443 | 205_234 | 546_317 |
| decode | 40_702 | 48_521 | 80_562 | 164_580 | 430_823 |


**Heap**

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|        |    len 0 |   len 10 |   len 32 |   len 64 |  len 128 |
| :----- | -------: | -------: | -------: | -------: | -------: |
| encode | 3.91 KiB | 4.16 KiB | 4.63 KiB | 5.29 KiB | 6.66 KiB |
| decode | 3.87 KiB | 3.98 KiB | 4.24 KiB | 4.61 KiB | 5.36 KiB |


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
| encode bech32  | 11_973 | 15_529 | 25_945 | 34_289 |
| encode bech32m | 12_005 | 15_561 | 25_977 | 34_321 |
| decode bech32  | 10_685 | 15_052 | 27_530 | 37_556 |
| decode bech32m | 10_759 | 15_150 | 27_604 | 37_618 |


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

|         | 2 utxos | 4 utxos |
| :------ | ------: | ------: |
| build   | 230_660 | 238_728 |
| sighash | 669_752 | 677_883 |


**Heap**

|         | 2 utxos | 4 utxos |
| :------ | ------: | ------: |
| build   |   272 B |   272 B |
| sighash |   272 B |   272 B |


**Garbage Collection**

|         |   2 utxos |   4 utxos |
| :------ | --------: | --------: |
| build   | 14.17 KiB | 14.64 KiB |
| sighash | 30.09 KiB | 30.56 KiB |


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
| DER+verify         | 307_343_274 | 306_581_361 |
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
| encode |  103_035 |  150_369 |  150_341 |  102_971 |  150_413 |  150_401 |
| decode |   49_276 |   71_960 |   71_951 |   49_244 |   72_000 |   71_975 |


**Heap**

|        | bc v0/20 | bc v0/32 | bc v1/32 | tb v0/20 | tb v0/32 | tb v1/32 |
| :----- | -------: | -------: | -------: | -------: | -------: | -------: |
| encode |    272 B |    272 B |    272 B |    272 B |    272 B |    272 B |
| decode |    272 B |    272 B |    272 B |    272 B |    272 B |    272 B |


**Garbage Collection**

|        | bc v0/20 | bc v0/32 | bc v1/32 | tb v0/20 | tb v0/32 | tb v1/32 |
| :----- | -------: | -------: | -------: | -------: | -------: | -------: |
| encode | 3.21 KiB | 4.21 KiB | 4.21 KiB | 3.21 KiB | 4.21 KiB | 4.21 KiB |
| decode | 1.72 KiB | 2.21 KiB | 2.21 KiB | 1.72 KiB | 2.21 KiB | 2.21 KiB |


</details>
