import Mont "Mont";

module {
  // Arithmetic computations modulo n, with values represented internally in
  // Montgomery form (`value` = `_value * R mod n`, R = 2^256). The constructor
  // takes an already-Mont value; use `fromNat` to wrap a natural-form Nat.
  // Use `toNat()` to obtain the natural representative when crossing a
  // boundary (e.g. for serialization, parity tests, or as a scalar for EC
  // scalar multiplication).
  public class Fp(_value : Nat, ctx : Mont.Ctx) : Fp = self {
    public let value : Nat = _value;

    public func toNat() : Nat = Mont.fromMont(value, ctx);

    public func inverse() : Fp = Fp(Mont.inverse(value, ctx), ctx);
    public func add(other : Fp) : Fp = Fp(Mont.add(value, other.value, ctx), ctx);
    public func mul(other : Fp) : Fp = Fp(Mont.mul(value, other.value, ctx), ctx);
    public func sqr() : Fp = Fp(Mont.sqr(value, ctx), ctx);
    public func sub(other : Fp) : Fp = Fp(Mont.sub(value, other.value, ctx), ctx);
    public func neg() : Fp = Fp(Mont.neg(value, ctx), ctx);
    public func isEqual(other : Fp) : Bool = other.value == value;
    public func pow(exponent : Nat) : Fp = Fp(Mont.pow(value, exponent, ctx), ctx);

    // Square root mod n. Assumes n ≡ 3 (mod 4).
    public func sqrt() : Fp = Fp(Mont.pow(value, (ctx.n + 1) / 4, ctx), ctx);
  };

  // Wrap a natural-form Nat into Fp (converts into Montgomery form).
  public func fromNat(natValue : Nat, ctx : Mont.Ctx) : Fp {
    Fp(Mont.toMont(natValue, ctx), ctx);
  };
};
