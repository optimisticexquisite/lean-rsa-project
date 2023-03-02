import Mathlib 
import Mathlib.Control.Random
import RSAProject.ALITER_Cipher

def MAX : Nat := 256
def MIN : Nat := 1
--          MULTIPLICATIVE INVERSE FUNCTION
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

def rnd (lo hi: Nat) : Nat := ((IO.rand lo hi).run' ()).get!

partial def coprime_generator (r:Nat) : Nat := 
 let n := rnd MIN MAX
 if 3 ≤ n ∧ Nat.gcd n r == 1 
 then n
 else coprime_generator r 

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

#eval prime_generator


----------KEY GENERATING FUNCTION-----------
partial def key_generator :  (Nat × Nat × Nat × Nat × Nat) := 
  let p := prime_generator 
  let rec loop (p:Nat): Nat :=
    let q := prime_generator 
    if q = p then loop p
    else q
  let q := loop p
  let n := p * q
  let r := (p - 1) * (q - 1)
  let c := coprime_generator r
  let d := multiplicative_inverse c r 
  (p, q, c, n, d)

   
 




