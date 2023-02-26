import Mathlib

def gcdA_adv (a : ℕ) (b : ℕ) : ℕ := 
--gcdA is a function defined in GCD.lean in mathlib. It directly returns a for GCD=ax+by
  let x := Nat.gcdA a b
  if x < 0 then 
  --Did this because gcdA is defined on ℤ. We can alternatively change GCD.lean to define gcdA on ℕ
    Int.toNat x + b -- Explicit Type Conversion
  else
    Int.toNat x
def public_key_generator (p : ℕ) (q : ℕ)(e : ℕ ) : ℕ ×  ℕ × ℕ := 
  let n := p * q 
  let prod :=  (p - 1) * (q - 1)
  if p = q then 
    (n,0,0) ^ panic! "p and q must be different"
  else
  if Nat.gcd e prod = 1 then
    let d  :=  gcdA_adv e prod
    (n,e,d)
  else
    (n,0,0)^ panic! "e and prod must be coprime"
 #eval public_key_generator 1223 1987 948047
def encrytion (m : ℕ) (e : ℕ) (n : ℕ) : ℕ := 
  let c := m^e % n
  c
def decryption (c : ℕ) (d : ℕ) (n : ℕ) : ℕ :=
  let m := c^d % n
  m
#eval encrytion 1070777 948047 2430101
#eval decryption 1473513 1051235 2430101
