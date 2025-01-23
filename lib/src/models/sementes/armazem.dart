class Armazem {
  final int? armNrId;
  final String armTxDescricao;
  final DateTime? armDtCreatedAt;
  final DateTime? armDtUpdateAt;
  final int ctaNrId;
  final bool? armBlAtivo;

  Armazem({
    this.armNrId,
    required this.armTxDescricao,
    this.armDtCreatedAt,
    this.armDtUpdateAt,
    required this.ctaNrId,
    this.armBlAtivo,
  });

  factory Armazem.fromJson(Map<String, dynamic> json) {
    return Armazem(
      armNrId: json['armNrId'],
      armTxDescricao: json['armTxDescricao'],
      armDtCreatedAt: DateTime.parse(json['armDtCreatedAt']),
      armDtUpdateAt: DateTime.parse(json['armDtUpdateAt']),
      ctaNrId: json['ctaNrId'],
      armBlAtivo: json['armBlAtivo'],
    );
  }

  @override
  String toString() {
    return 'Armazem{armNrId: $armNrId, armTxDescricao: $armTxDescricao,'
        'armDtCreatedAt: $armDtCreatedAt, '
        'armDtUpdateAt: $armDtUpdateAt, ctaNrId: $ctaNrId, armBlAtivo: $armBlAtivo}';
  }

  Map<String, dynamic> toJson() {
    return {
      'armTxDescricao': armTxDescricao,
      'ctaNrId': ctaNrId,
    };
  }
}
