class VocabularyWordModel {
  String userId;
  String palavra;
  String significado;
  String dificuldade;
  DateTime dataCriacao;
  DateTime dataAtualizacao;

  VocabularyWordModel({
    required this.userId,
    required this.palavra,
    required this.significado,
    required this.dificuldade,
    required this.dataCriacao,
    required this.dataAtualizacao,
  });
}
