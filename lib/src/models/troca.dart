class Troca {
  final String? troNrId;
  final String troTxInstrucoes;
  final String? sttTxStatus;
  final DateTime? sttDtStatusTroca;
  final DateTime? troDtCreatedAt;
  final String? usuNrIdRemetente;
  final String? usuTxNomeRemetente;
  final String? conTxNumeroRemetente;
  final int semNrIdSementeRemetente;
  final String? semTxNomeRemetente;
  final double troNrQuantidadeSementeRemetente;
  final String usuNrIdDestinatario;
  final String? usuTxNomeDestinatario;
  final String? conTxNumeroDestinatario;
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
    this.conTxNumeroRemetente,
    required this.semNrIdSementeRemetente,
    this.semTxNomeRemetente,
    required this.troNrQuantidadeSementeRemetente,
    required this.usuNrIdDestinatario,
    this.usuTxNomeDestinatario,
    this.conTxNumeroDestinatario,
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
      conTxNumeroRemetente: json['conTxNumeroRemetente'],
      semNrIdSementeRemetente: json['semNrIdSementeRemetente'] ?? 0,
      semTxNomeRemetente: json['semTxNomeRemetente'],
      troNrQuantidadeSementeRemetente:
          (json['troNrQuantidadeSementeRemetente'] ?? 0).toDouble(),
      usuNrIdDestinatario: json['usuNrIdDestinatario'] ?? '',
      usuTxNomeDestinatario: json['usuTxNomeDestinatario'],
      conTxNumeroDestinatario: json['conTxNumeroDestinatario'],
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
                  conTxNumeroRemetente: $conTxNumeroRemetente,
                  semNrIdSementeRemetente: $semNrIdSementeRemetente,
                  semTxNomeRemetente: $semTxNomeRemetente,
                  troNrQuantidadeSementeRemetente: $troNrQuantidadeSementeRemetente,
                  usuNrIdDestinatario: $usuNrIdDestinatario,
                  usuTxNomeDestinatario: $usuTxNomeDestinatario,
                  conTxNumeroDestinatario: $conTxNumeroDestinatario,
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
