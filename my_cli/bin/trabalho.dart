enum TipoConta { Poupanca, Salario, Corrente }

class Cliente {
  final String nome;
  final String cpf;

  Cliente(this.nome, this.cpf);
}

class Conta {
  final int numero;
  final Cliente cliente;
  double saldo;

  Conta(this.numero, this.cliente, this.saldo);

  void depositar(double valor) {
    if (valor <= 0) {
      throw Exception("O valor do depósito deve ser maior que zero.");
    }
    saldo += valor;
  }

  void sacar(double valor) {
    if (valor <= 0) {
      throw Exception("O valor do saque deve ser maior que zero.");
    }
    if (saldo >= valor) {
      saldo -= valor;
    } else {
      throw Exception("Saldo insuficiente para realizar o saque.");
    }
  }

  double consultarSaldo() {
    return saldo;
  }

  String gerarExtrato(DateTime inicio, DateTime fim) {
    if (inicio.isAfter(fim)) {
      throw Exception("A data de início deve ser anterior à data de fim.");
    }
    return "Extrato de ${cliente.nome} de $inicio até $fim: Saldo inicial: ${saldo + inicio.day}, Saldo final: ${saldo + fim.day}";
  }
}

class ContaPoupanca extends Conta {
  ContaPoupanca(int numero, Cliente cliente, double saldoInicial)
      : super(numero, cliente, saldoInicial) {
    if (saldoInicial < 50.0) {
      throw Exception("A conta poupança deve ser aberta com no mínimo R\$50,00.");
    }
  }

  void aplicarRendimento(double taxa) {
    if (taxa <= 0) {
      throw Exception("A taxa de rendimento deve ser maior que zero.");
    }
    saldo += saldo * taxa;
  }
}

class ContaSalario extends Conta {
  ContaSalario(int numero, Cliente cliente) : super(numero, cliente, 0);
}

class ContaCorrente extends Conta {
  ContaCorrente(int numero, Cliente cliente) : super(numero, cliente, 0);
}

class ContaConjunta extends Conta {
  final List<Cliente> titulares;

  ContaConjunta(int numero, this.titulares) : super(numero, titulares[0], 0) {
    if (titulares.length > 2) {
      throw Exception("A conta conjunta não pode ter mais de dois titulares.");
    }
  }

  void adicionarTitular(Cliente novoTitular) {
    if (titulares.length == 2) {
      throw Exception("A conta conjunta já possui o número máximo de titulares.");
    }
    titulares.add(novoTitular);
  }

  void removerTitular(Cliente titularRemovido) {
    if (titulares.length == 1) {
      throw Exception("A conta conjunta deve ter pelo menos um titular.");
    }
    if (titulares.contains(titularRemovido)) {
      titulares.remove(titularRemovido);
    } else {
      throw Exception("O titular especificado não está na conta conjunta.");
    }
  }
}

void main() {
  // Criar clientes
  final cliente1 = Cliente("Pedro", "123.456.789-00");
  final cliente2 = Cliente("Marcos", "987.654.321-00");

  // Criar contas
  final contaPoupanca = ContaPoupanca(1, cliente1, 100.0);
  final contaSalario = ContaSalario(2, cliente2);
  final contaCorrente = ContaCorrente(3, cliente2);
  final contaConjunta = ContaConjunta(4, [cliente1, cliente2]);

  // Realizar transações
  contaPoupanca.depositar(200.0);
  contaSalario.depositar(1000.0);
  contaCorrente.depositar(500.0);
  contaConjunta.depositar(300.0);
  
  contaPoupanca.sacar(50.0);
  contaSalario.sacar(200.0);
  contaCorrente.sacar(100.0);
  contaConjunta.sacar(150.0);

  // Exibir saldo
  print("Saldo conta poupança: R\$${contaPoupanca.consultarSaldo()}");
  print("Saldo conta salário: R\$${contaSalario.consultarSaldo()}");
  print("Saldo conta corrente: R\$${contaCorrente.consultarSaldo()}");
  print("Saldo conta conjunta: R\$${contaConjunta.consultarSaldo()}");

  // Gerar extrato
  final extrato = contaPoupanca.gerarExtrato(DateTime(2023, 1, 1), DateTime(2023, 9, 1));
  print(extrato);

  // Aplicar rendimento na conta poupança
  contaPoupanca.aplicarRendimento(0.03);

  // Exibir saldo após rendimento
  print("Saldo conta poupança após rendimento: R\$${contaPoupanca.consultarSaldo()}");

  // Adicionar e remover titulares na conta conjunta
  contaConjunta.adicionarTitular(Cliente("Lucas", "456.789.123-00"));
  print("Titulares da conta conjunta: ${contaConjunta.titulares.map((titular) => titular.nome).join(", ")}");
  
  contaConjunta.removerTitular(cliente1);
  print("Titulares da conta conjunta após remoção: ${contaConjunta.titulares.map((titular) => titular.nome).join(", ")}");
}
