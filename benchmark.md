Benchmark files:
• bench/base58.bench.mo
• bench/base58check.bench.mo
• bench/bech32.bench.mo
• bench/bip32.bench.mo
• bench/bitcoin_tx.bench.mo
• bench/ec_arith.bench.mo
• bench/ecdsa_verify.bench.mo
• bench/hash_hmac.bench.mo

==================================================

Starting pocket-ic replica...
Deploying canisters...

--------------------------------------------------

Running bench/base58.bench.mo...


				
Base58 encode/decode
				
Benchmark Base58 encode/decode across input sizes
				

Instructions

|        | len 0 | len 10 |  len 32 |    len 64 |   len 128 |
| :----- | ----: | -----: | ------: | --------: | --------: |
| encode | 1_927 | 42_113 | 309_474 | 1_145_187 | 4_400_863 |
| decode | 2_204 | 37_495 | 302_214 | 1_134_347 | 4_383_565 |
				

Heap

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |
				

Garbage Collection

|        | len 0 | len 10 |   len 32 |   len 64 |  len 128 |
| :----- | ----: | -----: | -------: | -------: | -------: |
| encode | 452 B |  892 B | 1.93 KiB | 3.48 KiB | 6.54 KiB |
| decode | 456 B |  612 B | 1.24 KiB | 2.18 KiB | 4.04 KiB |
				
			

--------------------------------------------------

Running bench/base58check.bench.mo...


				
Base58Check encode/decode
				
Benchmark Base58Check encode/decode across input sizes
				

Instructions

|        |  len 0 |  len 10 |  len 32 |    len 64 |   len 128 |
| :----- | -----: | ------: | ------: | --------: | --------: |
| encode | 51_744 | 115_430 | 438_842 | 1_364_372 | 4_793_843 |
| decode | 49_180 | 108_546 | 425_142 | 1_340_942 | 4_751_527 |
				

Heap

|        | len 0 | len 10 | len 32 | len 64 | len 128 |
| :----- | ----: | -----: | -----: | -----: | ------: |
| encode | 272 B |  272 B |  272 B |  272 B |   272 B |
| decode | 272 B |  272 B |  272 B |  272 B |   272 B |
				

Garbage Collection

|        |    len 0 |   len 10 |   len 32 |   len 64 |   len 128 |
| :----- | -------: | -------: | -------: | -------: | --------: |
| encode | 3.23 KiB | 3.77 KiB |    5 KiB | 6.77 KiB | 10.36 KiB |
| decode | 3.05 KiB | 3.34 KiB | 4.06 KiB | 5.11 KiB |  7.23 KiB |
				
			

--------------------------------------------------

Running bench/bech32.bench.mo...


				
Bech32 vs Bech32m (encode)
				
Compare Bech32 and Bech32m encoding across sizes
				

Instructions

|         |  len 0 |  len 5 | len 20 | len 32 |
| :------ | -----: | -----: | -----: | -----: |
| bech32  | 19_871 | 26_992 | 47_571 | 67_910 |
| bech32m | 20_177 | 27_298 | 47_877 | 68_216 |
				

Heap

|         | len 0 | len 5 | len 20 | len 32 |
| :------ | ----: | ----: | -----: | -----: |
| bech32  | 272 B | 272 B |  272 B |  272 B |
| bech32m | 272 B | 272 B |  272 B |  272 B |
				

Garbage Collection

|         |    len 0 |    len 5 |   len 20 |   len 32 |
| :------ | -------: | -------: | -------: | -------: |
| bech32  | 1.96 KiB | 2.19 KiB | 2.87 KiB | 3.54 KiB |
| bech32m | 1.96 KiB | 2.19 KiB | 2.87 KiB | 3.54 KiB |
				
			

--------------------------------------------------

Running bench/bip32.bench.mo...


				
BIP32 derivePath: text vs array
				
Compare path representations for public derivation
				

Instructions

|       |     depth 3 |     depth 4 |     depth 5 |
| :---- | ----------: | ----------: | ----------: |
| text  | 574_809_169 | 755_512_450 | 939_886_205 |
| array | 574_698_098 | 755_448_898 | 939_814_521 |
				

Heap

|       | depth 3 | depth 4 | depth 5 |
| :---- | ------: | ------: | ------: |
| text  |   272 B |   272 B |   272 B |
| array |   272 B |   272 B |   272 B |
				

Garbage Collection

|       |   depth 3 |   depth 4 |   depth 5 |
| :---- | --------: | --------: | --------: |
| text  | 14.03 MiB | 18.48 MiB | 23.01 MiB |
| array | 14.03 MiB | 18.47 MiB | 23.01 MiB |
				
			

--------------------------------------------------

Running bench/bitcoin_tx.bench.mo...


				
Bitcoin tx: build vs sighash
				
Compare building a simple tx vs computing P2PKH sighash
				

Instructions

|         |   2 utxos |   4 utxos |
| :------ | --------: | --------: |
| build   |   739_711 |   747_661 |
| sighash | 1_353_777 | 1_361_367 |
				

Heap

|         | 2 utxos | 4 utxos |
| :------ | ------: | ------: |
| build   |   272 B |   272 B |
| sighash |   272 B |   272 B |
				

Garbage Collection

|         |   2 utxos |   4 utxos |
| :------ | --------: | --------: |
| build   | 12.27 KiB | 12.74 KiB |
| sighash | 28.12 KiB |  28.6 KiB |
				
			

--------------------------------------------------

Running bench/ec_arith.bench.mo...


				
EC scalar mul: base vs arbitrary point
				
Compare scalar multiplication using generator vs arbitrary point
				

Instructions

|          |    k small |   k medium |    k large |
| :------- | ---------: | ---------: | ---------: |
| mulBase  | 10_051_216 | 17_908_116 | 36_197_846 |
| mulPoint | 10_046_392 | 17_904_012 | 36_192_302 |
				

Heap

|          | k small | k medium | k large |
| :------- | ------: | -------: | ------: |
| mulBase  |   272 B |    272 B |   272 B |
| mulPoint |   272 B |    272 B |   272 B |
				

Garbage Collection

|          |    k small |   k medium |    k large |
| :------- | ---------: | ---------: | ---------: |
| mulBase  | 324.09 KiB | 514.03 KiB | 976.75 KiB |
| mulPoint | 323.46 KiB |  513.4 KiB | 976.11 KiB |
				
			

--------------------------------------------------

Running bench/ecdsa_verify.bench.mo...


				
ECDSA verify: DER vs raw (DER decode cost)
				
Compare verifying using DER decode per run vs reusing parsed signature
				

Instructions

|                    |    sample 0 |    sample 1 |
| :----------------- | ----------: | ----------: |
| DER+verify         |  28_811_294 |  28_716_406 |
| verify (preparsed) | 151_491_557 | 152_789_627 |
				

Heap

|                    | sample 0 | sample 1 |
| :----------------- | -------: | -------: |
| DER+verify         |    272 B |    272 B |
| verify (preparsed) |    272 B |    272 B |
				

Garbage Collection

|                    |   sample 0 |   sample 1 |
| :----------------- | ---------: | ---------: |
| DER+verify         | 662.09 KiB | 654.92 KiB |
| verify (preparsed) |   3.79 MiB |   3.82 MiB |
				
			

--------------------------------------------------

Running bench/hash_hmac.bench.mo...


				
HMAC: SHA256 vs SHA512
				
Compare HMAC-SHA256 and HMAC-SHA512 across message sizes
				

Instructions

|             |   len 0 |  len 32 |  len 64 | len 256 |
| :---------- | ------: | ------: | ------: | ------: |
| HMAC-SHA256 | 105_568 | 112_919 | 129_442 | 199_817 |
| HMAC-SHA512 | 185_377 | 193_636 | 201_933 | 270_520 |
				

Heap

|             | len 0 | len 32 | len 64 | len 256 |
| :---------- | ----: | -----: | -----: | ------: |
| HMAC-SHA256 | 272 B |  272 B |  272 B |   272 B |
| HMAC-SHA512 | 272 B |  272 B |  272 B |   272 B |
				

Garbage Collection

|             |    len 0 |   len 32 |   len 64 |  len 256 |
| :---------- | -------: | -------: | -------: | -------: |
| HMAC-SHA256 | 3.97 KiB | 3.97 KiB | 3.97 KiB | 3.97 KiB |
| HMAC-SHA512 | 7.74 KiB | 7.94 KiB | 8.19 KiB | 9.66 KiB |
				
			
Stopping replica...
