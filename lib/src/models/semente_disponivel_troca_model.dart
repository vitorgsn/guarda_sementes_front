class SementeDisponivelTrocaModel {
  final int id;
  final bool? disponivel;
  final double quantidade;
  final int semNrIdSemente;
  final String observacoes;
  final DateTime createdAt;
  final DateTime updatedAt;

  SementeDisponivelTrocaModel({
    required this.id,
    this.disponivel,
    required this.quantidade,
    required this.semNrIdSemente,
    required this.observacoes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SementeDisponivelTrocaModel.fromJson(Map<String, dynamic> json) {
    return SementeDisponivelTrocaModel(
      id: json['sdtNrId'],
      disponivel: json['sdtBlDisponivel'],
      quantidade: (json['sdtNrQuantidade'] as num).toDouble(),
      semNrIdSemente: json['semNrIdSemente'],
      observacoes: json['sdtTxObservacoes'] ?? '',
      createdAt: DateTime.parse(json['sdtDtCreatedAt']),
      updatedAt: DateTime.parse(json['sdtDtUpdatedAt']),
    );
  }

  @override
  String toString() {
    return 'SementeDisponivelTrocaModel{id: $id, disponivel: $disponivel, quantidade: $quantidade, '
        'semNrIdSemente: $semNrIdSemente, observacoes: $observacoes, '
        'createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
