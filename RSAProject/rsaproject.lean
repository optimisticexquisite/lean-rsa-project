import Mathlib

-- I copied this function from https://github.com/Shraze97/RSA-cryptosystems/blob/master/RSACryptosystems.lean
-- This works, however the function gcdA doesn't seem to work
def inverse (a : ℕ) (b : ℕ) : ℕ := 
  let (x, _) := Nat.xgcd a b
  if x < 0 then 
    Int.toNat (x + b)
  else
    Int.toNat x

#eval inverse 7 6336 

def gcdA_adv (a : ℕ) (b : ℕ) : ℕ := 
--gcdA is a function defined in GCD.lean in mathlib. It directly returns a for GCD=ax+by
--This is the approach via Euclidian Algorithm. We can also use Gauss's Lemma to find the inverse of a mod b  
  let x := Nat.gcdA a b
  if x < 0 then 
  --Did this because gcdA is defined on ℤ. We can alternatively change GCD.lean to define gcdA on ℕ
    Int.toNat x + b -- Explicit Type Conversion
  else
    Int.toNat x
#eval gcdA_adv 7 6336
def public_key_generator (p : ℕ ) (q : ℕ)(e : ℕ ) : ℕ ×  ℕ × ℕ := 
  let n := p * q 
  let prod :=  (p - 1) * (q - 1)
  if p = q then 
    (n,0,0) ^ panic! "p and q must be different"
  else
  if Nat.gcd e prod = 1 then
    let d  :=  inverse e prod
    (n,e,d)
  else
    (n,0,0)^ panic! "e and prod must be coprime"
#eval public_key_generator 67 97 7
-- m is the message, e is the public key, n is the product of p and q
def encryption (m : ℕ) (e : ℕ) (n : ℕ) : ℕ := 
  let c := m^e % n
  c
-- c is the cipher text, d is the private key, n is the product of p and q
def decryption (c : ℕ) (d : ℕ) (n : ℕ) : ℕ :=
  let m := c^d % n
  m
#eval encryption 107 7 6499
#eval decryption 2501 5431 6499

-- Used partial def instead of def because it requires termination
partial def least_prime_factorization (n : ℕ) (div : ℕ): ℕ × ℕ :=
  if n % div = 0 then  (div,(n/div))
  else least_prime_factorization n (div+1)
 #eval least_prime_factorization 1591 2
-- #eval factorization 2430101
def decryption_by_brute_force (c : ℕ) (e : ℕ) (n : ℕ) : ℕ :=
   let (p,q) := least_prime_factorization n 2
    let prod := (p - 1) * (q - 1)
    let d := inverse e prod
    decryption c d n
#eval decryption_by_brute_force 2501 7 6499

-- #eval decryption_by_brute_force 1473513 2430101

