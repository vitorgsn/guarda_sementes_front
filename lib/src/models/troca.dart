class Troca {
  final int usuNrIdRemetente;
  final String usuTxNomeRemetente;
  final String semTxNomeRemetente;
  final double semNrQuantidadeRemetente;
  final int usuNrIdDestinatario;
  final String usuTxNomeDestinatario;
  final String semTxNomeDestinatario;
  final double semNrQuantidadeDestinatario;
  final String troNrId;
  final String troTxInstrucoes;
  final DateTime sttDtStatusTroca;
  final String sttTxStatus;

  Troca(
      {required this.usuNrIdRemetente,
      required this.usuTxNomeRemetente,
      required this.semTxNomeRemetente,
      required this.semNrQuantidadeRemetente,
      required this.usuNrIdDestinatario,
      required this.usuTxNomeDestinatario,
      required this.semTxNomeDestinatario,
      required this.semNrQuantidadeDestinatario,
      required this.troNrId,
      required this.troTxInstrucoes,
      required this.sttDtStatusTroca,
      required this.sttTxStatus});

  factory Troca.fromJson(Map<String, dynamic> json) {
    return Troca(
      usuNrIdRemetente: json['usuNrIdRemetente'],
      usuTxNomeRemetente: json['usuTxNomeRemetente'],
      semTxNomeRemetente: json['semTxNomeRemetente'],
      semNrQuantidadeRemetente: json['semNrQuantidadeRemetente'],
      usuNrIdDestinatario: json['usuNrIdDestinatario'],
      usuTxNomeDestinatario: json['usuTxNomeDestinatario'],
      semTxNomeDestinatario: json['semTxNomeDestinatario'],
      semNrQuantidadeDestinatario: json['semNrQuantidadeDestinatario'],
      troNrId: json['troNrId'],
      troTxInstrucoes: json['troTxInstrucoes'],
      sttDtStatusTroca: DateTime.parse(json['sttDtStatusTroca']),
      sttTxStatus: json['sttTxStatus'],
    );
  }

  @override
  String toString() {
    return 'Troca{usuNrIdRemetente: $usuNrIdRemetente, usuTxNomeRemetente: $usuTxNomeRemetente,'
        'semTxNomeRemetente: $semTxNomeRemetente, semNrQuantidadeRemetente: $semNrQuantidadeRemetente, usuNrIdDestinatario: $usuNrIdDestinatario, usuTxNomeDestinatario: $usuTxNomeDestinatario, semTxNomeDestinatario: $semTxNomeDestinatario, semNrQuantidadeDestinatario: $semNrQuantidadeDestinatario, troNrId: $troNrId, troTxInstrucoes: $troTxInstrucoes, sttDtStatusTroca: $sttDtStatusTroca, sttTxStatus: $sttTxStatus}';
  }

  Map<String, dynamic> toJson() {
    return {
      'usuNrIdRemetente': usuNrIdRemetente,
      'usuTxNomeRemetente': usuTxNomeRemetente,
      'semTxNomeRemetente': semTxNomeRemetente,
      'semNrQuantidadeRemetente': semNrQuantidadeRemetente,
      'usuNrIdDestinatario': usuNrIdDestinatario,
      'usuTxNomeDestinatario': usuTxNomeDestinatario,
      'semTxNomeDestinatario': semTxNomeDestinatario,
      'semNrQuantidadeDestinatario': semNrQuantidadeDestinatario,
      'troNrId': troNrId,
      'troTxInstrucoes': troTxInstrucoes,
      'sttDtStatusTroca': sttDtStatusTroca,
      'sttTxStatus': sttTxStatus
    };
  }
}
