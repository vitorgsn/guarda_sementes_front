import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/troca.dart';
import 'package:guarda_sementes_front/src/services/troca_service.dart';

class TrocaController with ChangeNotifier {
  final TrocaService _trocaService = TrocaService();
  List<Troca> _trocas = [];
  List<Troca> get trocas => _trocas;
  bool isLoading = false;

  Future<void> listarTrocas({Map<String, dynamic>? filtros}) async {
    isLoading = true;
    notifyListeners();

    try {
      _trocas = await _trocaService.listarTrocas(filtros: filtros);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> criarTroca(Troca troca) async {
    try {
      final novaTroca = await _trocaService.criarTroca(troca);
      _trocas.add(novaTroca!);
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

  Future<void> aceitarTroca(String troNrId) async {
    try {
      await _trocaService.aceitarTroca(troNrId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> recusarTroca(String troNrId) async {
    try {
      await _trocaService.recusarTroca(troNrId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelarTroca(String troNrId) async {
    try {
      await _trocaService.cancelarTroca(troNrId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
