class Troca {
  final String? troNrId;
  final String troTxInstrucoes;
  final String? sttTxStatus;
  final DateTime? sttDtStatusTroca;
  final DateTime? troDtCreatedAt;
  final String? usuNrIdRemetente;
  final String? usuTxNomeRemetente;
  final int semNrIdSementeRemetente;
  final String? semTxNomeRemetente;
  final double troNrQuantidadeSementeRemetente;
  final String usuNrIdDestinatario;
  final String? usuTxNomeDestinatario;
  final int semNrIdSementeDestinatario;
  final String? semTxNomeDestinatario;
  final double troNrQuantidadeSementeDestinatario;

  Troca({
    this.troNrId,
    required this.troTxInstrucoes,
    this.sttTxStatus,
    this.sttDtStatusTroca,
    this.troDtCreatedAt,
    this.usuNrIdRemetente,
    this.usuTxNomeRemetente,
    required this.semNrIdSementeRemetente,
    this.semTxNomeRemetente,
    required this.troNrQuantidadeSementeRemetente,
    required this.usuNrIdDestinatario,
    this.usuTxNomeDestinatario,
    required this.semNrIdSementeDestinatario,
    this.semTxNomeDestinatario,
    required this.troNrQuantidadeSementeDestinatario,
  });

  factory Troca.fromJson(Map<String, dynamic> json) {
    return Troca(
      troNrId: json['troNrId'],
      troTxInstrucoes: json['troTxInstrucoes'] ?? '',
      sttTxStatus: json['sttTxStatus'],
      sttDtStatusTroca: json['sttDtStatusTroca'] != null
          ? DateTime.tryParse(json['sttDtStatusTroca'])
          : null,
      troDtCreatedAt: json['troDtCreatedAt'] != null
          ? DateTime.tryParse(json['troDtCreatedAt'])
          : null,
      usuNrIdRemetente: json['usuNrIdRemetente'],
      usuTxNomeRemetente: json['usuTxNomeRemetente'],
      semNrIdSementeRemetente: json['semNrIdSementeRemetente'] ?? 0,
      semTxNomeRemetente: json['semTxNomeRemetente'],
      troNrQuantidadeSementeRemetente:
          (json['troNrQuantidadeSementeRemetente'] ?? 0).toDouble(),
      usuNrIdDestinatario: json['usuNrIdDestinatario'] ?? '',
      usuTxNomeDestinatario: json['usuTxNomeDestinatario'],
      semNrIdSementeDestinatario: json['semNrIdSementeDestinatario'] ?? 0,
      semTxNomeDestinatario: json['semTxNomeDestinatario'],
      troNrQuantidadeSementeDestinatario:
          (json['troNrQuantidadeSementeDestinatario'] ?? 0).toDouble(),
    );
  }

  @override
  String toString() {
    return '''Troca{
                  troNrId: $troNrId,
                  troTxInstrucoes: $troTxInstrucoes,
                  sttTxStatus: $sttTxStatus,
                  sttDtStatusTroca: $sttDtStatusTroca,
                  troDtCreatedAt: $troDtCreatedAt,
                  usuNrIdRemetente: $usuNrIdRemetente,
                  usuTxNomeRemetente: $usuTxNomeRemetente,
                  semNrIdSementeRemetente: $semNrIdSementeRemetente,
                  semTxNomeRemetente: $semTxNomeRemetente,
                  troNrQuantidadeSementeRemetente: $troNrQuantidadeSementeRemetente,
                  usuNrIdDestinatario: $usuNrIdDestinatario,
                  usuTxNomeDestinatario: $usuTxNomeDestinatario,
                  semNrIdSementeDestinatario: $semNrIdSementeDestinatario,
                  semTxNomeDestinatario: $semTxNomeDestinatario,
                  troNrQuantidadeSementeDestinatario: $troNrQuantidadeSementeDestinatario
                  }''';
  }

  Map<String, dynamic> toJson() {
    return {
      'troTxInstrucoes': troTxInstrucoes,
      'usuNrIdDestinatario': usuNrIdDestinatario,
      'semNrIdSementeDestinatario': semNrIdSementeDestinatario,
      'troNrQuantidadeSementeDestinatario': troNrQuantidadeSementeDestinatario,
      'semNrIdSementeRemetente': semNrIdSementeRemetente,
      'troNrQuantidadeSementeRemetente': troNrQuantidadeSementeRemetente,
    };
  }
}
