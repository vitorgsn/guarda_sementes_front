class SementeTrocaForm {
  final int semNrId;
  final double trsNrQuantidade;

  SementeTrocaForm({
    required this.semNrId,
    required this.trsNrQuantidade,
  });

  factory SementeTrocaForm.fromJson(Map<String, dynamic> json) {
    return SementeTrocaForm(
      semNrId: json['semNrId'],
      trsNrQuantidade: json['trsNrQuantidade'],
    );
  }

  @override
  String toString() {
    return 'SementeTrocaForm{semNrId: $semNrId, trsNrQuantidade: $trsNrQuantidade}';
  }

  Map<String, dynamic> toJson() {
    return {
      'semNrId': semNrId,
      'trsNrQuantidade': trsNrQuantidade,
    };
  }
}
