import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:guarda_sementes_front/src/services/semente_service.dart';

class SementeController with ChangeNotifier {
  final SementeService _sementeService = SementeService();
  List<Semente> _sementes = [];
  List<Semente> get sementes => _sementes;
  bool isLoading = false;

  Future<void> listarSementes({Map<String, dynamic>? filtros}) async {
    isLoading = true;
    notifyListeners();

    try {
      _sementes = [];
      notifyListeners();
      _sementes = await _sementeService.listarSementes(filtros: filtros);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> criarSemente(Semente semente) async {
    try {
      final novaSemente = await _sementeService.criarSemente(semente);
      _sementes.add(novaSemente!);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarSemente(Semente semente) async {
    try {
      final sementeAtualizada = await _sementeService.atualizarSemente(semente);
      final index = _sementes.indexWhere((e) => e.semNrId == semente.semNrId);
      if (index != -1) {
        _sementes[index] = sementeAtualizada!;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Semente?> buscarSementePorId(int semNrId) async {
    try {
      final semente = await _sementeService.buscarSementePorId(semNrId);

      if (semente != null) {
        final index = _sementes.indexWhere((e) => e.semNrId == semNrId);

        if (index != -1) {
          _sementes[index] = semente;
        } else {
          _sementes.add(semente);
        }

        notifyListeners();
      }

      return semente;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> excluirSemente(int semNrId) async {
    try {
      await _sementeService.excluirSemente(semNrId);
      _sementes.removeWhere((e) => e.semNrId == semNrId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
