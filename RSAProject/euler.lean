import Mathlib

open Nat

theorem euler_totient_theorem (a n : ℕ) (h : coprime a n) (hn : n ≠ 0) : a ^ φ n ≡ 1 [MOD n] :=
  haveI := Fact.mk hn,
  let a' := Zmod.unitOfCoprime a h,
  have hzmod : ((a' ^ φ n) : Zmod n) = a ^ φ n,
    from Zmod.pow_val a' (φ n),
  rw ←hzmod,
  have horder := order_of_min a' (φ_pos_of_ne_zero n hn),
  rw totient_unit_coprime n h at horder,
  exact pow_eq_mod_order_of.symm horder,
