import Mathlib 
import Mathlib.Control.Random
-- import RSAProject.ALITER_Cipher
import RSAProject.Sampling

def MAX : Nat := 12
def MIN : Nat := 1
--          MULTIPLICATIVE INVERSE FUNCTION
--we will use Euclid's algorithm to find multiplicative inverse of 
--natural number number n modulo natural number r.
--Note that a multiplicative inverse of n modulo r exists if and only if n,r are coprime 
--So,we need natural number k such that kn = 1 (mod r), or kn+br=1, for some interger b.  
--Euclid's algorithm gives us integers x, y such that xn+yr = 1.  
def multiplicative_inverse (n : Nat) (r : Nat) : Nat := 
  if Nat.gcd n r > 1
    then 0
  else         
    let (x, _) := Nat.xgcd n r --this gives k for kn+br=1
    if x > 0 then
       Int.toNat x --had to convert to Natural type
    else Int.toNat (x % r) --for negative x, we take x+r because x = x+r (mod r)   

#eval multiplicative_inverse 12 75
#eval multiplicative_inverse 15 821

--                 COPRIME NUMBER GENERATING FUNCTION
--Given a natural number r, we will generate a number coprime to it, provided that r is not divisible by each number between min & max
--def coprime_generator (r:Nat) : Nat := 
  --let l := List.range max 
  --let potential_coprime := List.filter (Nat.gcd · r = 1) l
  --match potential_coprime with 
 -- | [] => panic!"There is no number in the range that is coprime to the input"
 -- | (n::l) => n
 --For the time being, we make the following function using partial def. 

 
--partial def coprime_generator (r : Nat) : Nat :=
  --let n := (randNat MIN MAX)   
  --  if .toNat n >= 3 ∧ Nat.gcd (n r) = 1
  --then .toNat n 
  --else coprime_generator r  

  --def generateRandomNumber (min max : Nat) : IO Nat := do
  --let gen : StdGen := mkStdGen (← randNat MIN MAX)
  --let n : Nat := IO.runRand (StdRand.mk gen) fun g => RandomGen.oneOf (RandomGen.range g min max)
  --pure n

--For the time being, we make the following function using partial def. 
  def rangeFrom1ToN : (n:Nat) → List Nat
| 0   => []
| n+1 => (rangeFrom1ToN n) ++ [n+1]
def rnd (lo hi: Nat) : Nat := ((IO.rand lo hi).run' ()).get!

def coprime_generator (r:Nat) : Nat := 
 let n := pickElemD (rangeFrom1ToN MAX) (fun x => Nat.coprime r x) 2 (by simp) (by sorry)
 n

structure CoprimeTo (r : Nat) where
  coprime : Nat
  coprime_property : Nat.gcd coprime r = 1

-- partial def coprime_generatorIO (r:Nat) : IO (CoprimeTo r) := do
--  let n ← IO.rand  MIN MAX
--  if c:3 ≤ n ∧ Nat.gcd n r = 1 
 
--  then return ⟨n, c.right⟩
--  else coprime_generatorIO r 


----------- PRIME GENERATING FUNCTION --------
partial def while_loop (condition : IO Bool) (action : IO (Option Unit)) : IO Unit :=
  condition >>= fun c =>
  if c then
    action >>= fun _ =>
    while_loop condition action
  else
  pure ()

--partial def impure_prime_generator : IO Nat := do
  --let mut prime1 : Bool := false 
  --let mut number : Nat := 0 
  --while_loop (pure (prime1 == false)) do 
    --let mut divisor : Nat := 2
    --let mut divisor_2 : Nat := divisor^2
    --let mut random := rnd MIN MAX 
    --while_loop (pure (random = 1)) do
      --let mut random := rnd MIN MAX
      --let mut prime2 := True
    --while_loop (pure (divisor_2 < random)) do
      --let mut number := random%divisor
        --if number = 0 then 
          --let mut prime2 := false
          --impure_prime_generator
--def impure_prime_generator :IO Nat :=
  --let rec check_if_prime (divisor divisor_2 num : Nat) :IO Nat := do
    --if divisor_2 >= num then pure num
    --else do
      --let number := num % divisor
      --if number = 0 then impure_prime_generator
      --else
          --let divisor_ := 
            --match divisor with
            --| 2 => some 3
            --|_ => some (divisor + 2)
          --match divisor_ with
          --| none => pure()
 --def impure_prime_generator : IO Nat := do
  --let mut divisor := 2
  --let mut prime := false
  --let mut result := 0
  --let mut number := 0
  --let mut divisor2 := 4
  --while_loop (pure (prime == false)) do
    --let mut divisor := 2
    --let mut divisor2 := 4
    --let mut number ← IO.rand MIN MAX
    --while_loop (pure (divisor2 < number)) do
      --let mut result := number % divisor
      --if result = 0 then
        --let mut prime := false 
        --return ()
      --let mut divisor := if divisor = 2 then 3 else divisor + 2
      --let mut divisor2 := divisor^2  
      --if ¬ prime ∧ result ≠ 0 then
        --let mut prime := true 
  --return number

 
--def prime_generator : Nat:=
  --((impure_prime_generator).run' ()).get!          
          
def while_1 (result number divisor divisor2 : Nat): Nat :=                     
if (divisor2 < number ∧ result = 0) then 0
else if (divisor2 >= number) then 1
else if (divisor2 < number ∧ result ≠ 0 )  then       
        if (divisor > 2) then 2
        else 3
else 4         
partial def while_2 (result number divisor divisor2 : Nat) (prime : Bool): Nat :=      
if prime = false then
    if while_1 result number divisor divisor2 = 0 then 
      let number_1 := rnd MIN MAX 
      let result_1 := number_1%divisor
      while_2 result_1 number_1 divisor divisor2 prime 
    else if while_1 result number divisor divisor2 = 2
          then let divisor_1 := divisor + 2
            let divisor_1_sq := divisor_1*divisor_1
            let result_2 := number%divisor_1  
            while_2 result_2 number divisor_1 divisor_1_sq prime
    else if while_2 result number divisor divisor2 = 3
        then let divisor_2 := divisor + 1
          let divisor_2_sq := divisor_2*divisor_2
          let result_3 := number%divisor_2
          while_2 result_3 number divisor_2 divisor_2_sq prime 
    else
      if result > 0 
      then let prime1 := true
      while_2 result number divisor divisor2 prime1
      else let number_4 := rnd MIN MAX
           while_2 result number_4 divisor divisor2 prime          
else number

def prime_generator : Nat :=
let prime := false
let divisor := 2
let divisor2 := divisor*divisor
let number := 6
let result := 0 
while_2 result number divisor divisor2 prime

def remove_same_prime (p q : Nat) (l: List Nat) : (List Nat) :=
if p = q then
l.filter (fun x => x ≠ p)
else l

def prime_generator_ : Nat :=
pickElemD (rangeFrom1ToN MAX) (fun x => Nat.Prime x) 3 (by simp) rfl
theorem atleast_two_primes_in_range : (3 ∈ (List.remove 2 (rangeFrom1ToN MAX))) :=
by rw[List.mem_remove_iff]; simp
----------KEY GENERATING FUNCTION-----------
def key_generator :  (Nat × Nat × Nat × Nat × Nat) := 
  let p := 2
  --let newlist := remove_same_prime p p (rangeFrom1ToN MAX)

  --let q := pickElemD (newlist) (fun x => Nat.Prime x) 2 (by simp) (by apply atleast_two_primes_in_range)
  let q := prime_generator_
  if p = q then 
       if p = 2 then let newlist := remove_same_prime 2 2 (rangeFrom1ToN MAX)
        let q := pickElemD (newlist) (fun x => Nat.Prime x) 3 (by simp) rfl
        let n := p * q
        let r := (p - 1) * (q - 1)
        let c := coprime_generator r
        let d := multiplicative_inverse c r 
        (p, q, c, n, d)
        else if p = 3 then let newlist1 := remove_same_prime 3 3 (rangeFrom1ToN MAX)
        let q := pickElemD (newlist1) (fun x => Nat.Prime x) 2 (by simp) rfl
        let n := p * q
        let r := (p - 1) * (q - 1)
        let c := coprime_generator r
        let d := multiplicative_inverse c r 
        (p, q, c, n, d)
        else let q := 3
        let n := p * q
        let r := (p - 1) * (q - 1)
        let c := coprime_generator r
        let d := multiplicative_inverse c r
        (p, q, c, n, d)
  else 
  let n := p * q
  let r := (p - 1) * (q - 1)
  let c := coprime_generator r
  let d := multiplicative_inverse c r 
  (p, q, c, n, d)


#eval key_generator

-- Use the function to create a list of numbers from 1 to 5
-- def main : IO Unit := do
--   let myList : List Nat := rangeFrom1ToN 5
--   IO.println myList

#eval pickElemD [1,2,3,4,5,6,7,8,9,10,11,12] (fun x => Nat.Prime x) 2 (by simp) rfl

   
 




