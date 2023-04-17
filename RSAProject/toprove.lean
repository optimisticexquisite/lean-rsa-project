import RSAProject.rsaproject

theorem working1 : (decryption_by_brute_force (encryption e n m) e n ) = m := sorry

theorem working2 : (decryption (encryption e n m) d n ) = m := sorry

