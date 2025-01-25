class Semente {
  final int? semNrId;
  final String semTxNome;
  final double semNrQuantidade;
  final String semTxDescricao;
  final DateTime? semDtCreatedAt;
  final DateTime? semDtUpdateAt;
  final bool? semBlAtivo;
  final int armNrId;

  Semente({
    this.semNrId,
    required this.semTxNome,
    required this.semNrQuantidade,
    required this.semTxDescricao,
    this.semDtCreatedAt,
    this.semDtUpdateAt,
    this.semBlAtivo,
    required this.armNrId,
  });

  factory Semente.fromJson(Map<String, dynamic> json) {
    return Semente(
      semNrId: json['semNrId'],
      semTxNome: json['semTxNome'],
      semNrQuantidade: (json['semNrQuantidade']),
      semTxDescricao: json['semTxDescricao'],
      semDtCreatedAt: DateTime.parse(json['semDtCreatedAt']),
      semDtUpdateAt: DateTime.parse(json['semDtUpdateAt']),
      semBlAtivo: json['semBlAtivo'],
      armNrId: json['armNrId'],
    );
  }

  @override
  String toString() {
    return 'Semente{semNrId: $semNrId, semTxNome: $semTxNome, semNrQuantidade: $semNrQuantidade, '
        'semTxDescricao: $semTxDescricao, semDtCreatedAt: $semDtCreatedAt, '
        'semDtUpdateAt: $semDtUpdateAt, semBlAtivo: $semBlAtivo, armNrId: $armNrId}';
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
