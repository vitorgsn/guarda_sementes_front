class Cidade {
  final int? cidNrId;
  final String cidTxNome;
  final int estNrId;
  final String estTxNome;
  final String estTxSigla;

  Cidade({
    this.cidNrId,
    required this.cidTxNome,
    required this.estNrId,
    required this.estTxNome,
    required this.estTxSigla,
  });

  factory Cidade.fromJson(Map<String, dynamic> json) {
    return Cidade(
      cidNrId: json['cidNrId'],
      cidTxNome: json['cidTxNome'],
      estNrId: json['estNrId'],
      estTxNome: json['estTxNome'],
      estTxSigla: json['estTxSigla'],
    );
  }

  @override
  String toString() {
    return 'Cidade{cidNrId: $cidNrId, cidTxNome: $cidTxNome, estNrId: $estNrId, estTxNome: $estTxNome, estTxSigla: $estTxSigla}';
  }

  Map<String, dynamic> toJson() {
    return {
      'cidTxNome': cidTxNome,
      'estNrId': estNrId,
      'estTxNome': estTxNome,
      'estTxSigla': estTxSigla,
    };
  }
}
