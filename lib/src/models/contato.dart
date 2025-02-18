class Contato {
  final int? conNrId;
  final String conTxEmail;
  final String conTxNumero;
  final bool? conBlContatoPadrao;

  Contato({
    this.conNrId,
    required this.conTxEmail,
    required this.conTxNumero,
    this.conBlContatoPadrao,
  });

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      conNrId: json['conNrId'],
      conTxEmail: json['conTxEmail'],
      conTxNumero: json['conTxNumero'],
      conBlContatoPadrao: json['conBlContatoPadrao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conTxEmail': conTxEmail,
      'conTxNumero': conTxNumero,
      'conBlContatoPadrao': conBlContatoPadrao,
    };
  }

  @override
  String toString() {
    return 'Contato{conNrId: $conNrId, conTxEmail: $conTxEmail, conTxNumero: $conTxNumero, conBlContatoPadrao: $conBlContatoPadrao}';
  }
}
