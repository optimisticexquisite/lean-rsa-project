import Mathlib
-------CIPHER FUNCTION-----
partial def Cipher (exp string mod : Int) : Int :=
let result := 1;
let rec loop (exp string result : Int) : Int :=
  if exp = 0 then result
  else if exp % 2 = 1 then loop (exp/2) (string*string % mod) (result*string % mod)
  else loop (exp/2) (string*string % mod) result;
loop exp string result
