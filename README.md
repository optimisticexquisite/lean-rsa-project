# lean-rsa-project
A lean project on RSA encryption
RSA is an assymetric (public key) cryptographic algorithm. Public Key cryptography involves
generating a key pair, consisting of a public key and a private key. In the simplest
terms, the key is a set of numbers, which in some way are mathematically related.
The public key is used to encrypt messages and the private key to decrypt it. The recipient makes his public key available to the sender,
usually via the Internet or a network repository. The sender then encrypts the message using an algorithm that takes the recipient's public key as a parameter.
The message is then sent to the recipients. Messages can be encrypted only once. It is decrypted with the matching private key from the key-pair. 
To decipher the message,
a second algorithm is applied to the ciphertext using the private key.   
Since the public key is made publicly available, if a person intercepts the message, they also have access to it.
Therefore, the keys in the key pair must be related in a manner which makes it impossible to calculate the private key from the public key.
RSA is the most well known asymmetric cryptography. 
The primary goal of this project is to use Lean 4 as a platform for implementation of the key generation, encryption and
decryption algorithms as specified by the RSA specification. We plan to create a program to generate RSA public and private keys of minimum 2048 bits.
We will also create a program for encrypting and decrypting large numbers as well as text files using RSA. 
If time permits, we also plan to complete a peripheral objective of implementing the Chinese Remainder Theorem to facilitate decryption.
