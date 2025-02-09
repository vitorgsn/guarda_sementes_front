import 'package:guarda_sementes_front/src/models/semente_troca_form.dart';

class TrocaForm {
  final String troTxInstruncoes;
  final String usuNrIdDestinatario;
  final SementeTrocaForm ofertadaNasDisponiveis;
  final SementeTrocaForm ofertadaParaTroca;

  TrocaForm({
    required this.troTxInstruncoes,
    required this.usuNrIdDestinatario,
    required this.ofertadaNasDisponiveis,
    required this.ofertadaParaTroca,
  });

  factory TrocaForm.fromJson(Map<String, dynamic> json) {
    return TrocaForm(
      troTxInstruncoes: json['troTxInstruncoes'],
      usuNrIdDestinatario: json['usuNrIdDestinatario'],
      ofertadaNasDisponiveis: json['ofertadaNasDisponiveis'],
      ofertadaParaTroca: json['ofertadaParaTroca'],
    );
  }

  @override
  String toString() {
    return 'TrocaForm{troTxInstruncoes: $troTxInstruncoes, usuNrIdDestinatario: $usuNrIdDestinatario, ofertadaNasDisponiveis: $ofertadaNasDisponiveis, ofertadaParaTroca: $ofertadaParaTroca}';
  }

  Map<String, dynamic> toJson() {
    return {
      'troTxInstruncoes': troTxInstruncoes,
      'usuNrIdDestinatario': usuNrIdDestinatario,
      'ofertadaNasDisponiveis': ofertadaNasDisponiveis,
      'ofertadaParaTroca': ofertadaParaTroca,
    };
  }
}
