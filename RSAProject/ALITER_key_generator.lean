import Mathlib 

def max : Nat := 256
def min : Nat := 1
--MULTIPLICATIVE INVERSE FUNCTION
--we will use Euclid's algorithm to find multiplicative inverse of 
--natural number number n modulo natural number r.
--Note that a multiplicative inverse of n modulo r exists if and only if n,r are coprime 
--So,we need natural number k such that kn = 1 (mod r), or kn+br=1, for some interger b.  
--Euclid's algorithm gives us integers x, y such that xn+yr = 1.  
def multiplicative_inverse (n : Nat) (r : Nat) : Nat := 
  if Nat.gcd n r > 1
    then 1^panic!"input numbers are not coprime"
  else         
    let (x, _) := Nat.xgcd n r --this gives k for kn+br=1
    if x > 0 then
       Int.toNat x --had to convert to Natural type
    else Int.toNat (x+r) --for negative x, we take x+r because x = x+r (mod r)   

#eval multiplicative_inverse 12 75
#eval multiplicative_inverse 15 821

--COPRIME NUMBER GENERATING FUNCTION
--Given a natural number r, we will generate a number random coprime to it, provided that r is not divisible by each number between min & max
--def coprime_generator (r:Nat) : Nat := 
  --let l := List.range max 
  --let potential_coprime := List.filter (Nat.gcd · r = 1) l
  --match potential_coprime with 
 -- | [] => panic!"There is no number in the range that is coprime to the input"
 -- | (n::l) => n
 
      