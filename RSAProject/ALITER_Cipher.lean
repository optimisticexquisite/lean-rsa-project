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
  | exp' + 2 =>
    if exp' % 2 = 0 then
    have : succ (exp' / 2) < succ (succ exp') := by
      apply Nat.succ_lt_succ
      have ineq:= Nat.div_le_self exp' 2
      apply Nat.lt_of_le_of_lt ineq
      simp
    let c := cipher ((exp' + 2)/2) text mod
    (c * c) % mod
  else
    (text * (cipher (exp' + 1) text mod)) % mod
termination_by _ _ => exp


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



 