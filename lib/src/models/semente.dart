class Semente {
  final int? semNrId;
  final String semTxNome;
  final double semNrQuantidade;
  final String? semTxDescricao;
  final int armNrId;

  Semente({
    this.semNrId,
    required this.semTxNome,
    required this.semNrQuantidade,
    this.semTxDescricao,
    required this.armNrId,
  });

  factory Semente.fromJson(Map<String, dynamic> json) {
    return Semente(
      semNrId: json['semNrId'],
      semTxNome: json['semTxNome'],
      semNrQuantidade: (json['semNrQuantidade']),
      semTxDescricao: json['semTxDescricao'],
      armNrId: json['armNrId'],
    );
  }

  @override
  String toString() {
    return 'Semente{semNrId: $semNrId, semTxNome: $semTxNome, semNrQuantidade: $semNrQuantidade, semTxDescricao: $semTxDescricao, armNrId: $armNrId}';
  }

  Map<String, dynamic> toJson() {
    return {
      'semTxNome': semTxNome,
      'semNrQuantidade': semNrQuantidade,
      'semTxDescricao': semTxDescricao,
      'armNrId': armNrId,
    };
  }
}
