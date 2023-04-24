import Mathlib
import RSAProject.ALITER_key_generator
import Mathlib.Tactic.Find

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
#eval list_modulo (totient_list 7 11) 77

--- This function returns a list by multipying each element of the list by a
def new_totient_list (l : List Nat) (a : Nat) : List Nat := 
  l.map (fun x => x*a)


#eval list_modulo (totient_list 7 11) 77
#eval list_modulo (new_totient_list (totient_list 7 11) 9) 77
#eval new_totient_list (totient_list 7 11) 6

open Nat
open List

def coprime_list (n : ℕ) : List ℕ :=
List.filter (fun x => x.coprime n) (List.range n)

def is_group_modulo_n (n : ℕ) (l : List ℕ) : Prop :=
  (∀ a b : Nat, a ∈ l → b ∈ l →  (a * b) % n ∈ l) ∧ -- Closure under multiplication modulo n
  (∃ z ∈ l, ∀ a ∈ l, (a * z) % n = a) ∧ -- Existence of identity element
  (∀ a ∈ l, ∃ b ∈ l, (a * b) % n = 1) -- Existence of inverse elements

theorem product_of_two_primes_neq_zero (p: Nat) (q: Nat)  (hp: Nat.Prime p) (hq: Nat.Prime q) : p*q ≠ 0 := by
  have h1 : p ≠ 0 := by
    apply Nat.Prime.ne_zero hp
  have h2 : q ≠ 0 := by
    apply Nat.Prime.ne_zero hq
  have h3 : p*q ≠ 0 := by
    apply Nat.mul_ne_zero h1 h2
  apply h3
#check ZMod.card_units_eq_totient

instance ne_zero_product_of_primes {p q : ℕ} (hp : Nat.Prime p) (hq : Nat.Prime q) : NeZero (p * q) := by
  have h1 : p ≠ 0 := by
    apply Nat.Prime.ne_zero hp
  have h2 : q ≠ 0 := by
    apply Nat.Prime.ne_zero hq
  have h3 : p*q ≠ 0 := by
    apply Nat.mul_ne_zero h1 h2
  have h : NeZero (p*q) := ⟨h3⟩
  apply h
#check ne_zero_product_of_primes
#check orderOf
#check Subgroup.mem_closure_singleton
#check Subgroup.closure

def ZMod.ofInt {n : Nat} (z : Int) : ZMod n :=
  ⟨ z % n, _ ⟩ 


instance (n : Nat) : Coe Int (ZMod n) where
  coe := ZMod.ofInt

#eval ZMod 7
#eval Subgroup.closure (2 : (ZMod 7)ˣ)
-- instance : NeZero (n) := ⟨by apply product_of_two_primes_neq_zero⟩
-- Create subgroup out of an element
-- #find Int → ZMod _
#check fun n : Nat => inferInstanceAs <| Coe Int (ZMod n)

theorem euler_theorem (p: Nat) (q: Nat) (hp: Nat.Prime p) (hq: Nat.Prime q) [NeZero (p*q)] [list1: Fintype (ZMod (p*q))ˣ]:(∀ t ∈ list1 , (t ^ Nat.totient (p*q)) % (p*q) = 1):= by
  have h1: Fintype.card (ZMod (p*q))ˣ = Nat.totient (p*q) := by
    rw [ZMod.card_units_eq_totient]
  have h2: NeZero (p*q) := by
    apply ne_zero_product_of_primes hp hq
  have hp: Nat.Prime p := by
    apply hp
  have hq: Nat.Prime q := by
    apply hq
  have h3: (Nat.totient (p*q)) % (orderOf ((ZMod (p*q))ˣ [Monoid (ZMod (p*q))ˣ]))
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
  sorry

theorem product_same_modulo_pq (l1 : List Nat) (l2 : List Nat) (p : Nat) (q : Nat) (h1: List.Perm l1 l2) : product_of_all_elements_in_list (list_modulo l1 (p*q)) = product_of_all_elements_in_list (list_modulo l2 (p*q)) := by
  have h2: product_of_all_elements_in_list (list_modulo l1 (p*q)) = product_of_all_elements_in_list (list_modulo l2 (p*q)) := by
   rw [product_of_two_permutation_lists l1 l2 h1]
  apply h2
  sorry



-- theorem coprime_list_group (n : ℕ) (hn : 1 < n) : is_group_modulo_n n (coprime_list n) := by
 
--   split
--   { intros a b ha hb
--     rw [← mem_filter, ← mem_range] at ha hb
--     rw [← mem_filter, ← mem_range]
--     split
--     { apply mod_lt _ hn }
--     { exact coprime_mul (hb.right) (ha.right) } }
 

--   -- Closure under multiplication modulo n
--   { intros a b ha hb
--     rw [← mem_filter, ← mem_range] at ha hb
--     rw [← mem_filter, ← mem_range]
--     split
--     { apply mod_lt _ hn }
--     { exact coprime_mul (hb.right) (ha.right) } }

--   -- Existence of identity element
--   { use 1
--     split
--     { rw [← mem_filter, ← mem_range]
--       split
--       { exact lt_succ_self _ }
--       { exact coprime_one_left _ } }
--     { intros a ha
--       rw [mul_one, mod_eq_of_lt]
--       rw [← mem_filter, ← mem_range] at ha
--       exact ha.left } }

--   -- Existence of inverse elements
--   { intros a ha
--     rw [← mem_filter, ← mem_range] at ha
--     use a.coprime_reciprocal_left (pos_of_lt ha.left hn).ne' ha.right
--     split
--     { rw [← mem_filter, ← mem_range]
--       split
--       { apply mod_lt _ hn }
--       { exact ha.right.reciprocal_left_coprime } }
--     { rw [mul_comm, ← coprime_mul_eq_one_left (pos_of_lt ha.left hn).ne']
--       exact ha.right } }

-- theorem coprime_mul_permutation (n : ℕ) (hn : 1 < n) (x : ℕ) (hx : coprime x n) :
--   coprime_list n ~ List.map (fun a => (a * x) % n) (coprime_list n) := by
--   apply List.perm
--   intro a
--   rw [mem_map, mem_coprime_list, mem_coprime_list]
--   split
--   { rintro ⟨b, hb, rfl⟩
--     rw [← mem_coprime_list] at hb
--     exact coprime_mul_right hx hb.right }
--   { intro hxa
--     use a * coprime_reciprocal_left (pos_of_lt (mod_lt a hn) hn).ne' hx
--     split
--     { rw [← mem_coprime_list]
--       exact coprime_mul_right hx hxa }
--     { rw [mul_mod_right]
--       rw [← coprime_mul_eq_one_left (pos_of_lt (mod_lt a hn) hn).ne'] at hxa }}
     




#check List.mem_filter



-- def is_group (l : List Nat) : Prop :=
--   ∀ x y : Nat, x ∈ l → y ∈ l → x + y ∈ l -- Closure under addition
--   ∧ ∀ x : Nat, x ∈ l → ∃ y : Nat, y ∈ l ∧ x + y = 0 -- Existence of inverse element
--   ∧ ∀ x y z : Nat, x ∈ l → y ∈ l → z ∈ l → x + y = y + z → x = z -- Associativity of addition

  
  
