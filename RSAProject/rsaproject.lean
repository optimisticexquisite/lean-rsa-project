import Mathlib
import RSAProject.ALITER_key_generator

-- I copied this function from https://github.com/Shraze97/RSA-cryptosystems/blob/master/RSACryptosystems.lean
-- This works, however the function gcdA doesn't seem to work
def inverse (a : ℕ) (b : ℕ) : ℕ := 
  let (x, _) := Nat.xgcd a b
  if x < 0 then 
    Int.toNat (x + b)
  else
    Int.toNat x

#eval inverse 7 49 
#eval inverse 7 6336

partial def fast_powermod (a : ℕ) (b : ℕ) (n : ℕ) : ℕ :=
  if b = 0 then 1
  else if b % 2 = 0 then
    let x := fast_powermod a (b/2) n
    (x*x) % n
  else
    (a * fast_powermod a (b-1) n) % n


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
  if Nat.gcd e prod = 1 then
    let d  :=  inverse e prod
    (n,e,d)
  else
    (n,0,0)^ panic! "e and prod must be coprime"
-- #eval public_key_generator 67 97 (coprime_generator (66*96))
#eval public_key_generator 67 97 127

-- m is the message, e is the public key, n is the product of p and q
def encryption (m : ℕ) (e : ℕ) (n : ℕ) : ℕ := 
  -- let c := m^e % n
  let c := fast_powermod m e n
  c
-- c is the cipher text, d is the private key, n is the product of p and q
def decryption (c : ℕ) (d : ℕ) (n : ℕ) : ℕ :=
  -- let m := c^d % n
  let m := fast_powermod c d n
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

#check Nat.Prime
#eval Nat.Prime 7
#check Nat.totient_mul
-- #eval decryption_by_brute_force 1473513 2430101
#check Int.gcd_eq_one_iff_coprime

lemma totient_of_prime (p:Nat) (hp: Nat.Prime p): Nat.totient p = p - 1 := by
    rw [Nat.totient_prime hp]
theorem totient_product_of_two_primes (p q : Nat) (hp: Nat.Prime p) (hq: Nat.Prime q) (hr: p.coprime q) : Nat.totient (p*q) = (p - 1) * (q - 1) := by
  have h1 : Nat.totient (p*q) = Nat.totient p * Nat.totient q := by
   rw [Nat.totient_mul hr]
  have h2 : Nat.totient p * Nat.totient q = (p - 1) * (q - 1) := by
   rw [totient_of_prime p hp, totient_of_prime q hq]
  have h3 : Nat.totient (p*q) = (p - 1) * (q - 1) := by
   rw [h1, h2]
  apply h3
#check totient_product_of_two_primes 67 97
#check Nat.mul_one
#check Nat.coprime.mul
#check Nat.coprime_iff_gcd_eq_one

def rangeFrom1ToN : (n:Nat) → List Nat
| 0   => []
| n+1 => (rangeFrom1ToN n) ++ [n+1]

-- Use the function to create a list of numbers from 1 to 5
def main : IO Unit := do
  let myList : List Nat := rangeFrom1ToN 5
  IO.println myList

#eval main

theorem coprime_product_comprime (x : Nat) (z : Nat) (y : Nat) (hp: Nat.coprime x z) (hq: Nat.coprime y z) : Nat.coprime (x*y) z := by
  apply Nat.coprime.mul hp hq



theorem list_product_same_modulo (l1 : List ℕ) (a : ℕ) (n : ℕ) (hp: ∀ x ∈ l1, Nat.coprime x n) : ∀ x ∈ l1, Nat.coprime (x*a) n := by
  intro x
  intro hx
  have coprime_x_n : Nat.coprime x n := hp x hx
  rw [Nat.coprime, Nat.gcd_mul_left]
  rw [Nat.coprime] at coprime_x_n
  rw [coprime_x_n]
    

    
      
    
    