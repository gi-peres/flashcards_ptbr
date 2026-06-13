import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';

class GeminiService {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-3.1-flash-lite',
  );

  Future<String> _gerar(String prompt) async {
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? '';
  }

  static Map<String, dynamic> parseJson(String text) {
    final match = RegExp(r'\{.*\}', dotAll: true).firstMatch(text);
    return jsonDecode(match?.group(0) ?? '{}');
  }

  Future<Map<String, dynamic>> gerarPalavra(String dificuldade) async {
    final text = await _gerar('''
    Gere uma palavra não usual da língua portuguesa.

    Dificuldade:
    - TRINITY = fácil
    - MORPHEUS = média
    - NEO = difícil

    Retorne APENAS JSON: { "palavra": "", "significado": "" }

    Dificuldade escolhida: $dificuldade
    ''');

    return parseJson(text);
  }

  Future<Map<String, dynamic>> analisarResposta({
    required String palavra,
    required String significadoReal,
    required String respostaUsuario,
  }) async {
    final text = await _gerar('''
    Você é um avaliador de semântica.

    Palavra: $palavra
    Significado real: $significadoReal
    Resposta do jogador: $respostaUsuario

    Avalie semanticamente.

    Retorne APENAS JSON: { "porcentagem": 0, "feedback": "" }
    ''');

    return parseJson(text);
  }
}
