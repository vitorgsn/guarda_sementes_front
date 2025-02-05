class Armazem {
  final int? armNrId;
  final String armTxDescricao;
  final int ctaNrId;

  Armazem({
    this.armNrId,
    required this.armTxDescricao,
    required this.ctaNrId,
  });

  factory Armazem.fromJson(Map<String, dynamic> json) {
    return Armazem(
      armNrId: json['armNrId'],
      armTxDescricao: json['armTxDescricao'],
      ctaNrId: json['ctaNrId'],
    );
  }

  @override
  String toString() {
    return 'Armazem{armNrId: $armNrId, armTxDescricao: $armTxDescricao}';
  }

  Map<String, dynamic> toJson() {
    return {
      'armTxDescricao': armTxDescricao,
      'ctaNrId': ctaNrId,
    };
  }
}
