enum TipoC { P, S, C }

class Cl {
  final String n;
  final String i;

  Cl(this.n, this.i);
}

class A {
  final int n;
  double b;

  A(this.n, this.b);

  void d(double v) {
    if (v <= 0) {
      throw Exception("Valor do depósito deve ser maior que zero.");
    }
    b += v;
  }

  void s(double v) {
    if (v <= 0) {
      throw Exception("Valor do saque deve ser maior que zero.");
    }
    if (b >= v) {
      b -= v;
    } else {
      throw Exception("Saldo insuficiente para saque.");
    }
  }

  double c() {
    return b;
  }

  String g(DateTime i, DateTime f) {
    if (i.isAfter(f)) {
      throw Exception("Data de início deve ser anterior à data de fim.");
    }
    return "E ${n} de ${i} até ${f}: SI ${b + i.day}, SF ${b + f.day}";
  }
}

class Po extends A {
  Po(int n, Cl c, double s)
      : super(n, c, s) {
    if (s < 50.0) {
      throw Exception("Conta poupança deve ter no mínimo R\$50,00.");
    }
  }

  void a(double t) {
    if (t <= 0) {
      throw Exception("Taxa de rendimento deve ser maior que zero.");
    }
    b += b * t;
  }
}

class Sa extends A {
  Sa(int n, Cl c) : super(n, c, 0);
}

class Co extends A {
  final List<Cl> t;

  Co(int n, this.t) : super(n, t[0], 0) {
    if (t.length > 2) {
      throw Exception("Conta conjunta não pode ter mais de dois titulares.");
    }
  }

  void a(Cl n) {
    if (t.length == 2) {
      throw Exception("Conta conjunta já possui o número máximo de titulares.");
    }
    t.add(n);
  }

  void r(Cl t) {
    if (t.length == 1) {
      throw Exception("Conta conjunta deve ter pelo menos um titular.");
    }
    if (t.contains(t)) {
      t.remove(t);
    } else {
      throw Exception("Titular especificado não está na conta conjunta.");
    }
  }
}

void main() {
  final c1 = Cl("Pedro", "123.456.789-00");
  final c2 = Cl("Marcos", "987.654.321-00");

  final cp = Po(1, c1, 100.0);
  final cs = Sa(2, c2);
  final cc = Co(3, [c1, c2]);

  cp.d(200.0);
  cs.d(1000.0);
  cc.d(500.0);
  
  cp.s(50.0);
  cs.s(200.0);
  cc.s(100.0);

  print("Saldo cp: R\$${cp.c()}");
  print("Saldo cs: R\$${cs.c()}");
  print("Saldo cc: R\$${cc.c()}");

  final e = cp.g(DateTime(2023, 1, 1), DateTime(2023, 9, 1));
  print(e);

  cp.a(0.03);

  print("Saldo cp após rendimento: R\$${cp.c()}");

  cc.a(Cl("Lucas", "456.789.123-00"));
  print("Titulares da cc: ${cc.t.map((t) => t.n).join(", ")}");
  
  cc.r(c1);
  print("Titulares da cc após remoção: ${cc.t.map((t) => t.n).join(", ")}");
}