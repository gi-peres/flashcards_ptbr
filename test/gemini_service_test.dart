import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// 1. Criamos o "dublê" da nossa classe. Ele vai simular o comportamento da IA.
class MockGeminiService extends Mock {
  // Copiamos a assinatura das funções que queremos testar
  Future<Map<String, dynamic>> gerarPalavra(String dificuldade);
}

void main() {
  // 2. Criamos o grupo de testes unitários para organizar o trabalho
  group('Testes Unitários - Verbum AI Service', () {
    
    test('Deve retornar uma palavra e significado simulados com sucesso', () async {
      // Criamos a instância do nosso dublê
      final serviceDuble = MockGeminiService();

      // Ensinamos o dublê como reagir (Simulação/Mock)
      // "Quando chamarem gerarPalavra com o nível 'NEO', responda com esse JSON falso"
      when(() => serviceDuble.gerarPalavra('NEO')).thenAnswer(
        (_) async => {
          "palavra": "Pernicioso",
          "significado": "Que causa dano; prejudicial; nocivo."
        },
      );

      // Chamamos a função usando o nosso dublê
      final resultado = await serviceDuble.gerarPalavra('NEO');

      // Verificamos se o resultado é exatamente o que planejamos (Asserções)
      expect(resultado['palavra'], 'Pernicioso');
      expect(resultado['significado'], contains('nocivo'));
    });
  });
}