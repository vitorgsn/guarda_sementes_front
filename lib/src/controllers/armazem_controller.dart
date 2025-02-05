import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/armazem.dart';
import 'package:guarda_sementes_front/src/services/armazem_service.dart';

class ArmazemController with ChangeNotifier {
  final ArmazemService _armazemService = ArmazemService();
  List<Armazem> _armazens = [];
  List<Armazem> get armazens => _armazens;

  Future<void> listarArmazens({Map<String, dynamic>? filtros}) async {
    try {
      _armazens = await _armazemService.listarArmazens(filtros: filtros);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> criarArmazem(Armazem armazem) async {
    try {
      final novoArmazem = await _armazemService.criarArmazem(armazem);
      _armazens.add(novoArmazem!);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> excluirArmazem(int armNrId) async {
    try {
      await _armazemService.excluirArmazem(armNrId);
      _armazens.removeWhere((e) => e.armNrId == armNrId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
