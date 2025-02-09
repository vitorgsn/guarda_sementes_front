import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/troca.dart';
import 'package:guarda_sementes_front/src/models/troca_form.dart';
import 'package:guarda_sementes_front/src/services/troca_service.dart';

class TrocaController with ChangeNotifier {
  final TrocaService _trocaService = TrocaService();
  List<Troca> _trocas = [];
  List<Troca> get trocas => _trocas;

  Future<void> listarTrocas({Map<String, dynamic>? filtros}) async {
    try {
      _trocas = await _trocaService.listarTrocas(filtros: filtros);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> criarTroca(TrocaForm trocaForm) async {
    try {
      await _trocaService.criarTroca(trocaForm);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<Troca?> buscarTrocaPorId(String troNrId) async {
    try {
      final troca = await _trocaService.buscarTrocaPorId(troNrId);

      if (troca != null) {
        final index = _trocas.indexWhere((t) => t.troNrId == troNrId);

        if (index != -1) {
          _trocas[index] = troca;
        } else {
          _trocas.add(troca);
        }

        notifyListeners();
      }

      return troca;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> excluirTroca(String troNrId) async {
    try {
      await _trocaService.excluirTroca(troNrId);
      _trocas.removeWhere((t) => t.troNrId == troNrId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
