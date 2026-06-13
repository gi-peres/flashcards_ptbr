import 'package:verbum_app/gemini_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// =========================================================================
// 1. DUBLÊS DE TESTE (MOCKS)
// =========================================================================
class MockGeminiService extends Mock implements GeminiService {}

void main() {
  
  group('Testes Unitários - Verbum AI Service', () {

    // ---TESTE ORIGINAL (Garante o fluxo normal, está testando a lógica de sucesso e a 
    //estrutura de dados do aplicativo, simulando um cenário ideal.) ---
    test('Deve retornar uma palavra e significado simulados com sucesso (Usando Mock)', () async {
      // Criamos a instância do nosso dublê
      final serviceDuble = MockGeminiService();

      // Ensinamos o dublê como reagir (Simulação/Mock)
      when(() => serviceDuble.gerarPalavra('NEO')).thenAnswer(
        (_) async => {
          "palavra": "Pernicioso",
          "significado": "Que causa dano; prejudicial; nocivo."
        },
      );

      // Chamamos a função usando o nosso dublê
      final resultado = await serviceDuble.gerarPalavra('NEO');

      // Verificamos se o resultado é exatamente o que planejado
      expect(resultado['palavra'], 'Pernicioso');
      expect(resultado['significado'], contains('nocivo'));
    });


    // --- NOVO TESTE (Estratégia de Regressão solicitada, verifica se codigo está fazendo
    // a limpeza correta do json enviado pela IA) ---
    test('Estratégia de Regressão: Deve limpar o Markdown extra da IA e converter o JSON com sucesso', () {
      // 2. Criamos o cenário do BUG: o texto bruto exatamente como a IA costuma quebrar
      final respostaComBugDoGemini = """
      ```json
      {
        "palavra": "Pernicioso",
        "significado": "Que causa dano; prejudicial; nocivo."
      }
      ```
      """;

      // 3. Chamamos o método do seu app que limpa e decodifica a String.
      // (Se o seu método tiver outro nome no app, como 'tratarResposta', mude o nome aqui embaixo)
      final resultado = GeminiService.parseJson(respostaComBugDoGemini);

      // 4. Validação: Se a estratégia de regressão funcionar, o seu código real
      // vai limpar as crases automaticamente e ler os dados abaixo sem travar!
      expect(resultado['palavra'], 'Pernicioso');
      expect(resultado['significado'], contains('nocivo'));
    });

  });
}

// -------------------------------------------------------------------------
// ATENÇÃO: Se o compilador reclamar que a classe 'GeminiService' não existe
// ou não tem o método 'parseJson', certifique-se de que a função que você usa 
// para limpar o texto lá no seu arquivo original seja pública (sem o _ na frente)
// e tenha a mesma assinatura estruturada.
// -------------------------------------------------------------------------