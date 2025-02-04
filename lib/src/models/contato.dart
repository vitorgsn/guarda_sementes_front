class Contato {
  final int? conNrId;
  final String conTxEmail;
  final String conTxNumero;

  Contato({
    this.conNrId,
    required this.conTxEmail,
    required this.conTxNumero,
  });

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      conNrId: json['conNrId'],
      conTxEmail: json['conTxEmail'],
      conTxNumero: json['conTxNumero'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conTxEmail': conTxEmail,
      'conTxNumero': conTxNumero,
    };
  }

  @override
  String toString() {
    return 'Contato{conNrId: $conNrId, conTxEmail: $conTxEmail, conTxNumero: $conTxNumero}';
  }
}
