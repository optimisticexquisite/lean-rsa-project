# A lean project on RSA encryption
<br />
RSA is an assymetric (public key) cryptographic algorithm. Public Key cryptography involves
generating a key pair, consisting of a public key and a private key. In the simplest
terms, the key is a set of numbers, which in some way are mathematically related.<br />
The public key is used to encrypt messages and the private key to decrypt it. The recipient makes his public key available to the sender,
usually via the Internet or a network repository.<br /> The sender then encrypts the message using an algorithm that takes the recipient's public key as a parameter.<br />
The message is then sent to the recipients.<br /> Messages can be encrypted only once. It is decrypted with the matching private key from the key-pair. 
To decipher the message,
a second algorithm is applied to the ciphertext using the private key.   
Since the public key is made publicly available, if a person intercepts the message, they also have access to it.
Therefore, the keys in the key pair must be related in a manner which makes it impossible to calculate the private key from the public key.
RSA is the most well known asymmetric cryptography. 
The primary goal of this project is to use Lean 4 as a platform for implementation of the key generation, encryption and
decryption algorithms as specified by the RSA specification. We will also provide proof of correctness of the RSA algorithm, which primarily depends on Euler's theorem and the Chinese Remainder Theorem. 
We plan to create a program to generate RSA public and private keys of minimum 2048 bits.
We will also create a program for encrypting and decrypting large numbers as well as text files using RSA. If time permits, we also plan to complete a peripheral objective of implementing the Chinese Remainder Theorem to facilitate decryption.


# Technicalities
This project is running on Lean4 version leanprover/lean4:nightly-2023-02-10 <br /> <br />

Requires: Mathlib from https://github.com/leanprover-community/mathlib4.git <br /> <br />
To save time initializing this package, you can directly copy the folder "lake-packages" from another working Lean4 project folder with the specified requirements.


