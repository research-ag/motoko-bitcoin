// Montgomery modular arithmetic for odd moduli n.
//
// Values are represented in "Montgomery form" as `aR mod n`, where R is the
// libtommath-chosen normalization constant (smallest β^k > n for some
// implementation digit base β). Multiplication is performed via REDC: given
// 0 <= t < n*R, REDC(t) = t * R^-1 mod n.
//
// The setup constants and the REDC step are delegated to the runtime via
// `Prim.intMontgomery*` primitives, which wrap libtommath's Montgomery
// routines.
//
// Addition, subtraction, negation and equality are unchanged because Mont form
// is linear: (aR) + (bR) = (a+b)R mod n.

import Int "mo:core/Int";
import Prim "mo:prim";

module {
  public type Ctx = {
    n : Nat; // odd modulus
    mp : Int; // libtommath rho constant for n (mp_montgomery_setup)
    r2 : Nat; // R^2 mod n  (used to enter Mont form)
    one : Nat; // R mod n    (Mont form of 1)
  };

  // Build a context for the given odd modulus n.
  public func ctx(n : Nat) : Ctx {
    let mp = Prim.intMontgomerySetup(n);
    let one = Int.abs(Prim.intMontgomeryCalcNormalization(n));
    {
      n;
      mp;
      one;
      // R^2 mod n = (R mod n)^2 mod n.
      r2 = (one * one) % n;
    };
  };

  // REDC: given 0 <= t < n*R, returns t * R^-1 mod n in [0, n).
  public func redc(t : Nat, c : Ctx) : Nat {
    Int.abs(Prim.intMontgomeryReduce(t, c.n, c.mp));
  };

  // Mont multiply: (aR) * (bR) * R^-1 = (ab)R mod n.
  public func mul(a : Nat, b : Nat, c : Ctx) : Nat = redc(a * b, c);

  // Mont square.
  public func sqr(a : Nat, c : Ctx) : Nat = redc(a * a, c);

  // Convert a natural-form value into Mont form: a -> aR mod n.
  public func toMont(a : Nat, c : Ctx) : Nat = mul(a % c.n, c.r2, c);

  // Convert a Mont-form value back to natural form: aR -> a.
  public func fromMont(a : Nat, c : Ctx) : Nat = redc(a, c);

  // Mont add: inputs assumed in [0, n).
  public func add(a : Nat, b : Nat, c : Ctx) : Nat {
    let s = a + b;
    if (s >= c.n) { s - c.n } else { s };
  };

  // Mont subtract: inputs assumed in [0, n).
  public func sub(a : Nat, b : Nat, c : Ctx) : Nat {
    if (a >= b) { a - b } else { (a + c.n) - b };
  };

  // Mont negation: input assumed in [0, n).
  public func neg(a : Nat, c : Ctx) : Nat {
    if (a == 0) { 0 } else { c.n - a };
  };

  // Mont exponentiation: a is in Mont form, returns a^e in Mont form.
  // Square-and-multiply, left-to-right scan of the exponent's binary digits.
  public func pow(a : Nat, e : Nat, c : Ctx) : Nat {
    if (e == 0) { return c.one };
    var result = c.one;
    var base = a;
    var exp = e;
    while (exp > 0) {
      if (exp % 2 == 1) { result := mul(result, base, c) };
      exp /= 2;
      if (exp > 0) { base := sqr(base, c) };
    };
    result;
  };

  // Modular inverse: a is in Mont form (= aR), returns a^-1 in Mont form.
  // Delegates to the runtime's `intInvMod` (libtommath modular inverse) on
  // the natural-form representative. Traps if a is not coprime to n.
  public func inverse(a : Nat, c : Ctx) : Nat {
    let aNat = redc(a, c);
    let invNat = Int.abs(Prim.intInvMod(aNat, c.n));
    mul(invNat, c.r2, c);
  };
};
