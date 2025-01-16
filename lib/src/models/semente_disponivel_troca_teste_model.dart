class SementeDisponivelTrocaTesteModel {
  int sdtNrId;
  bool sdtBlDisponivel;
  double sdtNrQuantidade;
  int semNrIdSemente;
  String semTxNome;
  String sdtTxObservacoes;
  String icone;

  SementeDisponivelTrocaTesteModel({
    required this.sdtNrId,
    required this.sdtBlDisponivel,
    required this.semNrIdSemente,
    required this.semTxNome,
    required this.sdtTxObservacoes,
    required this.sdtNrQuantidade,
    required this.icone,
  });
}
