class Usuario {
  final String? usuNrId;
  final String usuTxNome;
  final String usuTxLogin;
  final bool? usuBlAtivo;

  Usuario({
    this.usuNrId,
    required this.usuTxNome,
    required this.usuTxLogin,
    this.usuBlAtivo,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      usuNrId: json['usuNrId'],
      usuTxNome: json['usuTxNome'],
      usuTxLogin: json['usuTxLogin'],
      usuBlAtivo: json['usuBlAtivo'],
    );
  }

  @override
  String toString() {
    return 'Usuario{usuNrId: $usuNrId, usuTxNome: $usuTxNome,'
        'usuBlAtivo: $usuBlAtivo}';
  }

  Map<String, dynamic> toJson() {
    return {
      'usuTxNome': usuTxNome,
      'usuTxLogin': usuTxLogin,
    };
  }
}
