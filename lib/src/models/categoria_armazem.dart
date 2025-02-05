class CategoriaArmazem {
  final int? ctaNrId;
  final String ctaTxNome;
  final String? ctaTxDescricao;

  CategoriaArmazem({
    this.ctaNrId,
    required this.ctaTxNome,
    this.ctaTxDescricao,
  });

  factory CategoriaArmazem.fromJson(Map<String, dynamic> json) {
    return CategoriaArmazem(
      ctaNrId: json['ctaNrId'],
      ctaTxNome: json['ctaTxNome'],
      ctaTxDescricao: json['ctaTxDescricao'],
    );
  }

  @override
  String toString() {
    return 'CategoriaArmazem{ctaNrId: $ctaNrId, ctaTxNome: $ctaTxNome, ctaTxDescricao: $ctaTxDescricao}';
  }

  Map<String, dynamic> toJson() {
    return {
      'ctaTxNome': ctaTxNome,
      'ctaTxDescricao': ctaTxDescricao,
    };
  }
}
