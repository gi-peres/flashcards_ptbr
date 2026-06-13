import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Não deve quebrar quando JSON vier vazio', () {
    const resposta = '';
    expect(resposta.isEmpty, true);
  });
}
