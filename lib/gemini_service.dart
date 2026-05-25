import 'package:firebase_ai/firebase_ai.dart';

class GeminiService {

  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-3.5-flash',
  );

  Future<Map<String, dynamic>> gerarPalavra(String dificuldade) async {

    final prompt = """
    Gere uma palavra não usual da língua portuguesa.

    Dificuldade:
    - TRINITY = fácil
    - MORPHEUS = média
    - NEO = difícil

    Retorne APENAS JSON:

    {
      "palavra": "",
      "significado": ""
    }

    Dificuldade escolhida: $dificuldade
    """;

    final response = await model.generateContent([
      Content.text(prompt)
    ]);

    final text = response.text ?? "";

    final palavra = RegExp(r'"palavra"\s*:\s*"([^"]+)"')
        .firstMatch(text)
        ?.group(1) ?? "";

    final significado = RegExp(r'"significado"\s*:\s*"([^"]+)"')
        .firstMatch(text)
        ?.group(1) ?? "";

    return {
      "palavra": palavra,
      "significado": significado,
    };
  }

  Future<Map<String, dynamic>> analisarResposta({
    required String palavra,
    required String significadoReal,
    required String respostaUsuario,
  }) async {

    final prompt = """
    Você é um avaliador de semântica.

    Palavra:
    $palavra

    Significado real:
    $significadoReal

    Resposta do jogador:
    $respostaUsuario

    Avalie semanticamente.

    Retorne APENAS JSON:

    {
      "porcentagem": 0,
      "feedback": ""
    }
    """;

    final response = await model.generateContent([
      Content.text(prompt)
    ]);

    final text = response.text ?? "";

    final porcentagem = int.tryParse(
      RegExp(r'"porcentagem"\s*:\s*(\d+)')
          .firstMatch(text)
          ?.group(1) ?? "0",
    ) ?? 0;

    final feedback = RegExp(r'"feedback"\s*:\s*"([^"]+)"')
            .firstMatch(text)
            ?.group(1) ??
        "";

    return {
      "porcentagem": porcentagem,
      "feedback": feedback,
    };
  }
}