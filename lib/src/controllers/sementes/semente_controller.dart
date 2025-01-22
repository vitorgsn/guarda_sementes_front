import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/sementes/semente.dart';
import 'package:guarda_sementes_front/src/services/sementes/semente_service.dart';

class SementeController with ChangeNotifier {
  final SementeService _sementeService = SementeService();
  List<Semente> _sementes = [];
  List<Semente> get sementes => _sementes;

  Future<void> listarSementes({Map<String, dynamic>? filtros}) async {
    try {
      _sementes = [];
      notifyListeners();
      _sementes = await _sementeService.listarSementes(filtros: filtros);
      notifyListeners();
    } catch (e) {
      print('Error fetching todos: $e');
    }
  }
}
