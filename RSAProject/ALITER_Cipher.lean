import Mathlib
import RSAProject.Sampling
namespace Nat
-------CIPHER FUNCTION-----

#check Nat.zero_le
def cipher (exp text mod : Nat) : Nat :=
  if mod = 0 then 0
  else
  match exp with 
  | 0 => 1
  | 1 => text % mod
  | exp + 2 => 
    if exp%2 = 0 then 
    let c := cipher ((exp + 2)/2) text mod
    (c * c) % mod
  else 
    (text * (cipher (exp + 1) text mod)) % mod
termination_by _ _ => exp
decreasing_by
have h01 : 1 < 2 := by trivial
simp
have h02 : 0 ≤ exp := by apply Nat.zero_le exp
have h1 :  (exp + 1) <  exp + 2 := by
  apply Nat.add_lt_add_left
  apply h01
simp[Nat.succ_eq_add_one]
have h2 :  ((exp + 2)/2) ≤  exp + 2 := by
  apply Nat.div_le_self
sorry

#eval cipher 4 3 5




---ENCRYPT FUNCTION----
def encrypt (exp text mod : Nat) : Nat :=
--Note: we need text < mod
let result := cipher exp text mod 
result
---DECRYPT FUNCTION---
def decrypt (ciphertext exp mod : Nat) : Nat :=
let result := cipher exp ciphertext mod
result

---Prove that the cipher function is a bijection---
theorem cipher_bijection (exp text mod : Nat) : 
  cipher exp text mod = cipher exp (cipher exp text mod) mod := by
  induction exp with exp ih,
  { simp[cipher] },
  { simp[cipher],
    rw[ih] },
  { simp[cipher],
    rw[ih] }
    

 