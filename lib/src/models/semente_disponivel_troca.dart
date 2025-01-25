class SementeDisponivelTroca {
  final int? stdNrId;
  final double stdNrQuantidade;
  final String sdtTxObservacoes;
  final DateTime? stdDtCreatedAt;
  final DateTime? stdDtUpdatedAt;
  final bool? stdBlDisponivel;
  final int semNrIdSemente;

  SementeDisponivelTroca({
    this.stdNrId,
    required this.stdNrQuantidade,
    required this.sdtTxObservacoes,
    this.stdDtCreatedAt,
    this.stdDtUpdatedAt,
    this.stdBlDisponivel,
    required this.semNrIdSemente,
  });

  factory SementeDisponivelTroca.fromJson(Map<String, dynamic> json) {
    return SementeDisponivelTroca(
      stdNrId: json['stdNrId'],
      stdNrQuantidade: (json['stdNrQuantidade']),
      sdtTxObservacoes: json['sdtTxObservacoes'],
      stdDtCreatedAt: DateTime.parse(json['stdDtCreatedAt']),
      stdDtUpdatedAt: DateTime.parse(json['stdDtUpdatedAt']),
      stdBlDisponivel: json['stdBlDisponivel'],
      semNrIdSemente: json['semNrIdSemente'],
    );
  }

  @override
  String toString() {
    return 'SementeDisponivelTroca{stdNrId: $stdNrId, stdNrQuantidade: $stdNrQuantidade, '
        'sdtTxObservacoes: $sdtTxObservacoes, stdDtCreatedAt: $stdDtCreatedAt, '
        'stdDtUpdatedAt: $stdDtUpdatedAt, stdBlDisponivel: $stdBlDisponivel, semNrIdSemente: $semNrIdSemente}';
  }

  Map<String, dynamic> toJson() {
    return {
      'stdNrQuantidade': stdNrQuantidade,
      'sdtTxObservacoes': sdtTxObservacoes,
      'semNrIdSemente': semNrIdSemente,
    };
  }
}
