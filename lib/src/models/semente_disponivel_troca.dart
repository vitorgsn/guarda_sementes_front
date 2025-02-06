class SementeDisponivelTroca {
  final int? sdtNrId;
  final bool? sdtBlDisponivel;
  final double sdtNrQuantidade;
  final String sdtTxObservacoes;
  final int semNrIdSemente;
  final String? semTxNome;
  final int? cidNrId;
  final String? cidTxNome;
  final int? estNrId;
  final String? estTxNome;
  final String? estTxSigla;

  SementeDisponivelTroca({
    this.sdtNrId,
    this.sdtBlDisponivel,
    required this.sdtNrQuantidade,
    required this.sdtTxObservacoes,
    required this.semNrIdSemente,
    this.semTxNome,
    this.cidNrId,
    this.cidTxNome,
    this.estNrId,
    this.estTxNome,
    this.estTxSigla,
  });

  factory SementeDisponivelTroca.fromJson(Map<String, dynamic> json) {
    return SementeDisponivelTroca(
      sdtNrId: json['sdtNrId'],
      sdtBlDisponivel: json['sdtBlDisponivel'],
      sdtNrQuantidade: json['sdtNrQuantidade'],
      sdtTxObservacoes: json['sdtTxObservacoes'],
      semNrIdSemente: json['semNrIdSemente'],
      semTxNome: json['semTxNome'],
      cidNrId: json['cidNrId'],
      cidTxNome: json['cidTxNome'],
      estNrId: json['estNrId'],
      estTxNome: json['estTxNome'],
      estTxSigla: json['estTxSigla'],
    );
  }

  @override
  String toString() {
    return 'SementeDisponivelTroca{sdtNrId: $sdtNrId, sdtBlDisponivel: $sdtBlDisponivel, sdtNrQuantidade: $sdtNrQuantidade, sdtTxObservacoes: $sdtTxObservacoes, semNrIdSemente: $semNrIdSemente, semTxNome: $semTxNome, cidNrId: $cidNrId, cidTxNome: $cidTxNome, estNrId: $estNrId, estTxNome: $estTxNome, estTxSigla: $estTxSigla}';
  }

  Map<String, dynamic> toJson() {
    return {
      'sdtNrQuantidade': sdtNrQuantidade,
      'sdtTxObservacoes': sdtTxObservacoes,
      'semNrIdSemente': semNrIdSemente,
    };
  }
}
