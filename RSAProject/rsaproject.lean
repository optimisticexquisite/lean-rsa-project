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

-- def rangeFrom1ToN : (n:Nat) → List Nat
-- | 0   => []
-- | n+1 => (rangeFrom1ToN n) ++ [n+1]

-- Use the function to create a list of numbers from 1 to 5
def main : IO Unit := do
  let myList : List Nat := rangeFrom1ToN 5
  IO.println myList

#eval main

theorem coprime_product_comprime (x : Nat) (z : Nat) (y : Nat) (hp: Nat.coprime x z) (hq: Nat.coprime y z) : Nat.coprime (x*y) z := by
  apply Nat.coprime.mul hp hq


#check List.remove

def list_of_multiples_of_p_till_q (p: Nat) (q: Nat) : List Nat := 
  let newlist := rangeFrom1ToN q
  let newlist2 := newlist.map (fun x => x*p)
  newlist2
#eval list_of_multiples_of_p_till_q 7 49

def totient_list (p: Nat) (q: Nat) : List Nat := 
  let newlist := rangeFrom1ToN (p*q)
  List.filter (fun x => x.coprime (p*q))
  newlist
#eval totient_list 7 11

def list_modulo (l : List Nat) (n : Nat) : List Nat := 
  l.map (fun x => x % n)

--- This function returns a list by multipying each element of the list by a
def new_totient_list (l : List Nat) (a : Nat) : List Nat := 
  l.map (fun x => x*a)


#eval list_modulo (totient_list 7 11) 77
#eval list_modulo (new_totient_list (totient_list 7 11) 9) 77
#eval new_totient_list (totient_list 7 11) 6

def is_group (l : List Nat) : Prop :=
  ∀ x y : Nat, x ∈ l → y ∈ l → x + y ∈ l -- Closure under addition
  ∧ ∀ x : Nat, x ∈ l → ∃ y : Nat, y ∈ l ∧ x + y = 0 -- Existence of inverse element
  ∧ ∀ x y z : Nat, x ∈ l → y ∈ l → z ∈ l → x + y = y + z → x = z -- Associativity of addition


---This theorem proves that list_modulo of new_totient_list is equal to list_modulo of totient_list if p and q are prime and a is coprime to p*q
theorem permutation_of_totient_list (p : Nat) (q : Nat) (a : Nat) (hp: Nat.Prime p) (hq: Nat.Prime q) (hr: Nat.coprime a (p*q)) : list_modulo (new_totient_list (totient_list p q) a) (p*q) = list_modulo (totient_list p q) (p*q) := by
  --Use List.Perm
 have h1: List.Perm (list_modulo (new_totient_list (totient_list p q) a) (p*q)) (list_modulo (totient_list p q) (p*q)) := by
  sorry
  
def product_of_all_elements_in_list (l : List Nat) : Nat := 
  l.foldl (fun x y => x*y) 1
#eval product_of_all_elements_in_list [1,2,3,4,5]

--- If two lists are permutations of each other, then their product is equal
theorem product_of_two_permutation_lists (l1 : List Nat) (l2 : List Nat) (h1: List.Perm l1 l2) : product_of_all_elements_in_list l1 = product_of_all_elements_in_list l2 := by
  have h2: l1 = l2 := by
   apply permutation_of_totient_list
  have h3: product_of_all_elements_in_list l1 = product_of_all_elements_in_list l2 := by
   rw [h2]
  apply h3

theorem product_same_modulo_pq (l1 : List Nat) (l2 : List Nat) (p : Nat) (q : Nat) (h1: List.Perm l1 l2) : product_of_all_elements_in_list (list_modulo l1 (p*q)) = product_of_all_elements_in_list (list_modulo l2 (p*q)) := by
  have h2: product_of_all_elements_in_list (list_modulo l1 (p*q)) = product_of_all_elements_in_list (list_modulo l2 (p*q)) := by
   rw [product_of_two_permutation_lists l1 l2 h1]
  apply h2

  
  
