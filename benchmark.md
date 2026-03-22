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
| encode | 1_918 | 42_104 | 309_465 | 1_145_178 | 4_400_854 |
| decode | 2_195 | 37_486 | 302_205 | 1_134_338 | 4_383_556 |


**Heap**

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|        | len 0 | len 10 |   len 32 |   len 64 |  len 128 |
| :----- | ----: | -----: | -------: | -------: | -------: |
| encode | 452 B |  892 B | 1.93 KiB | 3.48 KiB | 6.54 KiB |
| decode | 456 B |  612 B | 1.24 KiB | 2.18 KiB | 4.04 KiB |


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
| encode | 51_608 | 115_401 | 438_813 | 1_364_343 | 4_793_814 |
| decode | 49_175 | 108_541 | 425_137 | 1_340_937 | 4_751_522 |


**Heap**

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|        |    len 0 |   len 10 |   len 32 |   len 64 |   len 128 |
| :----- | -------: | -------: | -------: | -------: | --------: |
| encode | 3.19 KiB | 3.77 KiB |    5 KiB | 6.77 KiB | 10.36 KiB |
| decode | 3.05 KiB | 3.34 KiB | 4.06 KiB | 5.11 KiB |  7.23 KiB |


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
| bech32  | 30_427 | 42_642 | 85_651 | 125_181 |
| bech32m | 30_765 | 42_997 | 85_959 | 125_531 |


**Heap**

|         | len 0 | len 5 | len 20 | len 32 |
| :------ | ----: | ----: | -----: | -----: |
| bech32  | 272 B | 272 B |  272 B |  272 B |
| bech32m | 272 B | 272 B |  272 B |  272 B |


**Garbage Collection**

|         |    len 0 |    len 5 |   len 20 |   len 32 |
| :------ | -------: | -------: | -------: | -------: |
| bech32  | 1.71 KiB | 2.03 KiB | 3.12 KiB | 4.14 KiB |
| bech32m | 1.71 KiB | 2.03 KiB | 3.12 KiB | 4.14 KiB |


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
| text  | 544_790_130 | 725_733_952 | 910_312_763 |
| array | 544_684_515 | 725_667_160 | 910_236_443 |


**Heap**

|       | depth 3 | depth 4 | depth 5 |
| :---- | ------: | ------: | ------: |
| text  |   272 B |   272 B |   272 B |
| array |   272 B |   272 B |   272 B |


**Garbage Collection**

|       |  depth 3 |   depth 4 |   depth 5 |
| :---- | -------: | --------: | --------: |
| text  | 13.4 MiB | 17.85 MiB | 22.39 MiB |
| array | 13.4 MiB | 17.85 MiB | 22.39 MiB |


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
| build   |   744_730 |   752_652 |
| sighash | 1_396_768 | 1_404_330 |


**Heap**

|         | 2 utxos | 4 utxos |
| :------ | ------: | ------: |
| build   |   272 B |   272 B |
| sighash |   272 B |   272 B |


**Garbage Collection**

|         |   2 utxos |   4 utxos |
| :------ | --------: | --------: |
| build   | 11.66 KiB | 12.13 KiB |
| sighash | 25.81 KiB | 26.28 KiB |


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
| mulBase  | 10_061_620 | 17_926_736 | 36_232_205 |
| mulPoint | 10_056_796 | 17_922_632 | 36_226_598 |


**Heap**

|          | k small | k medium | k large |
| :------- | ------: | -------: | ------: |
| mulBase  |   272 B |    272 B |   272 B |
| mulPoint |   272 B |    272 B |   272 B |


**Garbage Collection**

|          |    k small |   k medium |    k large |
| :------- | ---------: | ---------: | ---------: |
| mulBase  | 323.28 KiB | 513.55 KiB |    977 KiB |
| mulPoint | 322.64 KiB | 512.92 KiB | 976.36 KiB |


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
| DER+verify         |  28_925_636 |  28_831_426 |
| verify (preparsed) | 151_605_700 | 152_875_585 |


**Heap**

|                    | sample 0 | sample 1 |
| :----------------- | -------: | -------: |
| DER+verify         |    272 B |    272 B |
| verify (preparsed) |    272 B |    272 B |


**Garbage Collection**

|                    |   sample 0 |  sample 1 |
| :----------------- | ---------: | --------: |
| DER+verify         | 662.85 KiB | 656.9 KiB |
| verify (preparsed) |   3.79 MiB |  3.82 MiB |


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
| HMAC-SHA256 | 107_042 | 114_393 | 130_916 | 201_291 |
| HMAC-SHA512 | 185_587 | 193_846 | 202_143 | 270_730 |


**Heap**

|             | len 0 | len 32 | len 64 | len 256 |
| :---------- | ----: | -----: | -----: | ------: |
| HMAC-SHA256 | 272 B |  272 B |  272 B |   272 B |
| HMAC-SHA512 | 272 B |  272 B |  272 B |   272 B |


**Garbage Collection**

|             |    len 0 |   len 32 |   len 64 |  len 256 |
| :---------- | -------: | -------: | -------: | -------: |
| HMAC-SHA256 | 3.97 KiB | 3.97 KiB | 3.97 KiB | 3.97 KiB |
| HMAC-SHA512 | 7.74 KiB | 7.94 KiB | 8.19 KiB | 9.66 KiB |


</details>
