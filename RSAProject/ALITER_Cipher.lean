import Mathlib
-------CIPHER FUNCTION-----
partial def cipher (exp text mod : Int) : Int :=
let result := 1;
let rec loop (exp text result : Int) : Int :=
  if exp = 0 then result
  else if exp % 2 = 1 then loop (exp/2) (text*text % mod) (result*text % mod)
  else loop (exp/2) (text*text % mod) result;
loop exp text result
---ENCRYPT FUNCTION----
def encrypt (exp text mod : Int) : Int :=
--Note: we need text < mod
let result := cipher exp text mod 
result
---DECRYPT FUNCTION---
def decrypt (ciphertext exp mod : Int) : Int :=
let result := cipher exp ciphertext mod
result