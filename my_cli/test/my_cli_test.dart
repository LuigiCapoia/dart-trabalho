import 'package:my_cli/my_cli.dart';
import 'package:test/test.dart';

void main() {
  test('T1', () {
    expect(() => CP(1, C("P", "123.456.789-00"), 40.0), throwsException);
  });

  test('T2', () {
    final cp = CP(1, C("P", "123.456.789-00"), 100.0);
    final cs = CS(2, C("M", "987.654.321-00"));

    cp.d(50.0);
    cs.d(500.0);

    expect(cp.c(), 150.0);
    expect(cs.c(), 500.0);

    cp.s(30.0);
    cs.s(100.0);

    expect(cp.c(), 120.0);
    expect(cs.c(), 400.0);
  });

  test('T3', () {
    final cp = CP(1, C("P", "123.456.789-00"), 100.0);

    final e = cp.g(DateTime(2023, 1, 1), DateTime(2023, 9, 1));

    expect(
        e,
        "E P de 2023-01-01 00:00:00.000 até 2023-09-01 00:00:00.000: SI 130, SF 120");
  });

  test('T4', () {
    final cp = CP(1, C("P", "123.456.789-00"), 100.0);

    cp.a(0.03);

    expect(cp.c(), 103.0);
  });

  test('T5', () {
    final c1 = C("P", "123.456.789-00");
    final c2 = C("M", "987.654.321-00");

    final cc = Cc(1, [c1]);

    cc.a(c2);

    expect(cc.t.length, 2);

    cc.a(C("M", "456.789.123-00"));

    expect(() => cc.a(C("J", "789.123.456-00")), throwsException);

    cc.t.remove(c2);

    expect(cc.t.length, 1);
  });
}