// Lean compiler output
// Module: RSAProject.rsaproject
// Imports: Init Mathlib
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
static lean_object* l_public__key__generator___closed__2;
static lean_object* l_public__key__generator___closed__6;
LEAN_EXPORT lean_object* l_public__key__generator___boxed(lean_object*, lean_object*, lean_object*);
static lean_object* l_public__key__generator___closed__4;
uint8_t l_Nat_instDecidableCoprime(lean_object*, lean_object*);
static lean_object* l_public__key__generator___closed__5;
lean_object* l_panic___at_String_toNat_x21___spec__1(lean_object*);
static lean_object* l_public__key__generator___closed__3;
lean_object* lean_nat_to_int(lean_object*);
LEAN_EXPORT lean_object* l_encryption___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_encryption(lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Util_0__mkPanicMessageWithDecl(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_gcdA__adv(lean_object*, lean_object*);
lean_object* lean_nat_pow(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_mod(lean_object*, lean_object*);
lean_object* l_Nat_gcdA(lean_object*, lean_object*);
lean_object* l_Int_toNat(lean_object*);
LEAN_EXPORT lean_object* l_decryption___boxed(lean_object*, lean_object*, lean_object*);
uint8_t lean_int_dec_lt(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
static lean_object* l_public__key__generator___closed__1;
static lean_object* l_gcdA__adv___closed__1;
LEAN_EXPORT lean_object* l_decryption(lean_object*, lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_public__key__generator(lean_object*, lean_object*, lean_object*);
static lean_object* _init_l_gcdA__adv___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(0u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_gcdA__adv(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; lean_object* x_4; uint8_t x_5; 
lean_inc(x_2);
x_3 = l_Nat_gcdA(x_1, x_2);
x_4 = l_gcdA__adv___closed__1;
x_5 = lean_int_dec_lt(x_3, x_4);
if (x_5 == 0)
{
lean_object* x_6; 
lean_dec(x_2);
x_6 = l_Int_toNat(x_3);
lean_dec(x_3);
return x_6;
}
else
{
lean_object* x_7; lean_object* x_8; 
x_7 = l_Int_toNat(x_3);
lean_dec(x_3);
x_8 = lean_nat_add(x_7, x_2);
lean_dec(x_2);
lean_dec(x_7);
return x_8;
}
}
}
static lean_object* _init_l_public__key__generator___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_from_bytes("RSAProject.rsaproject", 21);
return x_1;
}
}
static lean_object* _init_l_public__key__generator___closed__2() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_from_bytes("public_key_generator", 20);
return x_1;
}
}
static lean_object* _init_l_public__key__generator___closed__3() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_from_bytes("e and prod must be coprime", 26);
return x_1;
}
}
static lean_object* _init_l_public__key__generator___closed__4() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_1 = l_public__key__generator___closed__1;
x_2 = l_public__key__generator___closed__2;
x_3 = lean_unsigned_to_nat(21u);
x_4 = lean_unsigned_to_nat(13u);
x_5 = l_public__key__generator___closed__3;
x_6 = l___private_Init_Util_0__mkPanicMessageWithDecl(x_1, x_2, x_3, x_4, x_5);
return x_6;
}
}
static lean_object* _init_l_public__key__generator___closed__5() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_from_bytes("p and q must be different", 25);
return x_1;
}
}
static lean_object* _init_l_public__key__generator___closed__6() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_1 = l_public__key__generator___closed__1;
x_2 = l_public__key__generator___closed__2;
x_3 = lean_unsigned_to_nat(15u);
x_4 = lean_unsigned_to_nat(14u);
x_5 = l_public__key__generator___closed__5;
x_6 = l___private_Init_Util_0__mkPanicMessageWithDecl(x_1, x_2, x_3, x_4, x_5);
return x_6;
}
}
LEAN_EXPORT lean_object* l_public__key__generator(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; uint8_t x_9; 
x_4 = lean_nat_mul(x_1, x_2);
x_5 = lean_unsigned_to_nat(1u);
x_6 = lean_nat_sub(x_1, x_5);
x_7 = lean_nat_sub(x_2, x_5);
x_8 = lean_nat_mul(x_6, x_7);
lean_dec(x_7);
lean_dec(x_6);
x_9 = lean_nat_dec_eq(x_1, x_2);
if (x_9 == 0)
{
uint8_t x_10; 
x_10 = l_Nat_instDecidableCoprime(x_3, x_8);
if (x_10 == 0)
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; 
lean_dec(x_8);
lean_dec(x_3);
x_11 = l_public__key__generator___closed__4;
x_12 = l_panic___at_String_toNat_x21___spec__1(x_11);
x_13 = lean_nat_pow(x_4, x_12);
lean_dec(x_4);
x_14 = lean_unsigned_to_nat(0u);
x_15 = lean_nat_pow(x_14, x_12);
lean_dec(x_12);
lean_inc(x_15);
x_16 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_16, 0, x_15);
lean_ctor_set(x_16, 1, x_15);
x_17 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_17, 0, x_13);
lean_ctor_set(x_17, 1, x_16);
return x_17;
}
else
{
lean_object* x_18; lean_object* x_19; lean_object* x_20; 
lean_inc(x_3);
x_18 = l_gcdA__adv(x_3, x_8);
x_19 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_19, 0, x_3);
lean_ctor_set(x_19, 1, x_18);
x_20 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_20, 0, x_4);
lean_ctor_set(x_20, 1, x_19);
return x_20;
}
}
else
{
lean_object* x_21; lean_object* x_22; lean_object* x_23; lean_object* x_24; lean_object* x_25; lean_object* x_26; lean_object* x_27; 
lean_dec(x_8);
lean_dec(x_3);
x_21 = l_public__key__generator___closed__6;
x_22 = l_panic___at_String_toNat_x21___spec__1(x_21);
x_23 = lean_nat_pow(x_4, x_22);
lean_dec(x_4);
x_24 = lean_unsigned_to_nat(0u);
x_25 = lean_nat_pow(x_24, x_22);
lean_dec(x_22);
lean_inc(x_25);
x_26 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_26, 0, x_25);
lean_ctor_set(x_26, 1, x_25);
x_27 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_27, 0, x_23);
lean_ctor_set(x_27, 1, x_26);
return x_27;
}
}
}
LEAN_EXPORT lean_object* l_public__key__generator___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l_public__key__generator(x_1, x_2, x_3);
lean_dec(x_2);
lean_dec(x_1);
return x_4;
}
}
LEAN_EXPORT lean_object* l_encryption(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; 
x_4 = lean_nat_pow(x_1, x_2);
x_5 = lean_nat_mod(x_4, x_3);
lean_dec(x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* l_encryption___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l_encryption(x_1, x_2, x_3);
lean_dec(x_3);
lean_dec(x_2);
lean_dec(x_1);
return x_4;
}
}
LEAN_EXPORT lean_object* l_decryption(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; 
x_4 = lean_nat_pow(x_1, x_2);
x_5 = lean_nat_mod(x_4, x_3);
lean_dec(x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* l_decryption___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l_decryption(x_1, x_2, x_3);
lean_dec(x_3);
lean_dec(x_2);
lean_dec(x_1);
return x_4;
}
}
lean_object* initialize_Init(uint8_t builtin, lean_object*);
lean_object* initialize_Mathlib(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_RSAProject_rsaproject(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Mathlib(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_gcdA__adv___closed__1 = _init_l_gcdA__adv___closed__1();
lean_mark_persistent(l_gcdA__adv___closed__1);
l_public__key__generator___closed__1 = _init_l_public__key__generator___closed__1();
lean_mark_persistent(l_public__key__generator___closed__1);
l_public__key__generator___closed__2 = _init_l_public__key__generator___closed__2();
lean_mark_persistent(l_public__key__generator___closed__2);
l_public__key__generator___closed__3 = _init_l_public__key__generator___closed__3();
lean_mark_persistent(l_public__key__generator___closed__3);
l_public__key__generator___closed__4 = _init_l_public__key__generator___closed__4();
lean_mark_persistent(l_public__key__generator___closed__4);
l_public__key__generator___closed__5 = _init_l_public__key__generator___closed__5();
lean_mark_persistent(l_public__key__generator___closed__5);
l_public__key__generator___closed__6 = _init_l_public__key__generator___closed__6();
lean_mark_persistent(l_public__key__generator___closed__6);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
