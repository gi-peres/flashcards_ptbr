import 'package:flutter_test/flutter_test.dart';
import 'package:verbum_app/vocabulary_word_model.dart';

void main() {
  test('Deve criar objeto VocabularyWordModel corretamente', () {
    final palavra = VocabularyWordModel(
      userId: '123',
      palavra: 'Abissal',
      significado: 'Muito profundo',
      dificuldade: 'NEO',
      dataCriacao: DateTime.now(),
      dataAtualizacao: DateTime.now(),
    );

    expect(palavra.userId, '123');
    expect(palavra.palavra, 'Abissal');
    expect(palavra.significado, 'Muito profundo');
    expect(palavra.dificuldade, 'NEO');
  });
}