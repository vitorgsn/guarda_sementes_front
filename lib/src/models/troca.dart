class Troca {
  final String usuNrIdRemetente;
  final String? usuTxNomeRemetente;
  final int semNrIdRemetente;
  final String? semTxNomeRemetente;
  final double semNrQuantidadeRemetente;
  final String usuNrIdDestinatario;
  final String? usuTxNomeDestinatario;
  final int semNrIdDestinatario;
  final String? semTxNomeDestinatario;
  final double semNrQuantidadeDestinatario;
  final String? troNrId;
  final String troTxInstrucoes;
  final DateTime? sttDtStatusTroca;
  final String? sttTxStatus;

  Troca({
    required this.usuNrIdRemetente,
    this.usuTxNomeRemetente,
    required this.semNrIdRemetente,
    this.semTxNomeRemetente,
    required this.semNrQuantidadeRemetente,
    required this.usuNrIdDestinatario,
    this.usuTxNomeDestinatario,
    required this.semNrIdDestinatario,
    this.semTxNomeDestinatario,
    required this.semNrQuantidadeDestinatario,
    this.troNrId,
    required this.troTxInstrucoes,
    this.sttDtStatusTroca,
    this.sttTxStatus,
  });

  factory Troca.fromJson(Map<String, dynamic> json) {
    return Troca(
      usuNrIdRemetente: json['usuNrIdRemetente'],
      usuTxNomeRemetente: json['usuTxNomeRemetente'],
      semNrIdRemetente: json['semNrIdRemetente'],
      semTxNomeRemetente: json['semTxNomeRemetente'],
      semNrQuantidadeRemetente: json['semNrQuantidadeRemetente'],
      usuNrIdDestinatario: json['usuNrIdDestinatario'],
      usuTxNomeDestinatario: json['usuTxNomeDestinatario'],
      semNrIdDestinatario: json['semNrIdDestinatario'],
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
    return 'Troca{usuNrIdRemetente: $usuNrIdRemetente, usuTxNomeRemetente: $usuTxNomeRemetente, semNrIdRemetente: $semNrIdRemetente, semTxNomeRemetente: $semTxNomeRemetente, semNrQuantidadeRemetente: $semNrQuantidadeRemetente, usuNrIdDestinatario: $usuNrIdDestinatario, usuTxNomeDestinatario: $usuTxNomeDestinatario, semTxNomeDestinatario: $semTxNomeDestinatario, semNrQuantidadeDestinatario: $semNrQuantidadeDestinatario, troNrId: $troNrId, troTxInstrucoes: $troTxInstrucoes, sttDtStatusTroca: $sttDtStatusTroca, sttTxStatus: $sttTxStatus}';
  }

  Map<String, dynamic> toJson() {
    return {
      'usuNrIdRemetente': usuNrIdRemetente,
      'semNrIdRemetente': semNrIdRemetente,
      'semNrQuantidadeRemetente': semNrQuantidadeRemetente,
      'usuNrIdDestinatario': usuNrIdDestinatario,
      'semNrIdDestinatario': semNrIdDestinatario,
      'semNrQuantidadeDestinatario': semNrQuantidadeDestinatario,
      'troTxInstrucoes': troTxInstrucoes,
    };
  }
}
