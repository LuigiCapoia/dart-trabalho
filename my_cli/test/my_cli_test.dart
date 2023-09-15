import 'package:my_cli/my_cli.dart';
import 'package:test/test.dart';



//teste
void main() {
  test('Teste conta poupança com saldo inicial insuficiente', () {
    expect(() => ContaPoupanca(1, Cliente("Pedro", "123.456.789-00"), 40.0),
        throwsException);
  });

  test('Teste depositar e sacar dinheiro das contas', () {
    final contaPoupanca = ContaPoupanca(1, Cliente("Pedro", "123.456.789-00"), 100.0);
    final contaSalario = ContaSalario(2, Cliente("Marcos", "987.654.321-00"));

    contaPoupanca.depositar(50.0);
    contaSalario.depositar(500.0);

    expect(contaPoupanca.consultarSaldo(), 150.0);
    expect(contaSalario.consultarSaldo(), 500.0);

    contaPoupanca.sacar(30.0);
    contaSalario.sacar(100.0);

    expect(contaPoupanca.consultarSaldo(), 120.0);
    expect(contaSalario.consultarSaldo(), 400.0);
  });

  test('Teste gerar extrato', () {
    final contaPoupanca = ContaPoupanca(1, Cliente("Pedro", "123.456.789-00"), 100.0);

    final extrato = contaPoupanca.gerarExtrato(DateTime(2023, 1, 1), DateTime(2023, 9, 1));

    expect(
        extrato,
        "Extrato de João de 2023-01-01 00:00:00.000 até 2023-09-01 00:00:00.000: Saldo inicial: 130, Saldo final: 120");
  });

  test('Teste aplicar rendimento na conta poupança', () {
    final contaPoupanca = ContaPoupanca(1, Cliente("Pedro", "123.456.789-00"), 100.0);

    contaPoupanca.aplicarRendimento(0.03);

    expect(contaPoupanca.consultarSaldo(), 103.0);
  });

  test('Teste adicionar e remover titulares na conta conjunta', () {
    final cliente1 = Cliente("Pedro", "123.456.789-00");
    final cliente2 = Cliente("Marcos", "987.654.321-00");

    final contaConjunta = ContaConjunta(1, [cliente1]);

    contaConjunta.adicionarTitular(cliente2);

    expect(contaConjunta.titulares.length, 2);

    contaConjunta.adicionarTitular(Cliente("Matheus", "456.789.123-00"));

    expect(() => contaConjunta.adicionarTitular(Cliente("João", "789.123.456-00")),
        throwsException);

    contaConjunta.titulares.remove(cliente2);

    expect(contaConjunta.titulares.length, 1);
  });
}
