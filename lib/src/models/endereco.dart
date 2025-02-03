class Endereco {
  final int? endNrId;
  final String endTxBairro;
  final String endTxLogradouro;
  final String endTxNumero;
  final String endTxReferencia;
  final bool? endBlEnderecoPadrao;
  final int? cidNrId;
  final String? cidTxNome;
  final int? estNrId;
  final String? estTxNome;
  final String? estTxSigla;

  Endereco({
    this.endNrId,
    required this.endTxBairro,
    required this.endTxLogradouro,
    required this.endTxNumero,
    required this.endTxReferencia,
    this.endBlEnderecoPadrao,
    required this.cidNrId,
    this.cidTxNome,
    this.estNrId,
    this.estTxNome,
    this.estTxSigla,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      endNrId: json['endNrId'],
      endTxBairro: json['endTxBairro'],
      endTxLogradouro: json['endTxLogradouro'],
      endTxNumero: json['endTxNumero'],
      endTxReferencia: json['endTxReferencia'],
      endBlEnderecoPadrao: json['endBlEnderecoPadrao'],
      cidNrId: json['cidNrId'],
      cidTxNome: json['cidTxNome'],
      estNrId: json['estNrId'],
      estTxNome: json['estTxNome'],
      estTxSigla: json['estTxSigla'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'endTxBairro': endTxBairro,
      'endTxLogradouro': endTxLogradouro,
      'endTxNumero': endTxNumero,
      'endTxReferencia': endTxReferencia,
      'endBlEnderecoPadrao': endBlEnderecoPadrao,
      'cidNrId': cidNrId,
    };
  }

  @override
  String toString() {
    return 'Endereco{endNrId: $endNrId, endTxBairro: $endTxBairro, endTxLogradouro: $endTxLogradouro, endTxNumero: $endTxNumero,'
        'endTxReferencia: $endTxReferencia, endBlEnderecoPadrao: $endBlEnderecoPadrao, cidNrId: $cidNrId, '
        'cidTxNome: $cidTxNome, estNrId: $estNrId, estTxNome: $estTxNome, estTxSigla: $estTxSigla}';
  }
}
