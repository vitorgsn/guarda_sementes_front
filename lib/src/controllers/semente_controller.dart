import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:guarda_sementes_front/src/services/semente_service.dart';

class SementeController with ChangeNotifier {
  final SementeService _sementeService = SementeService();
  List<Semente> _sementes = [];

  List<Semente> get todos => _sementes;

  Future<void> listarSementes() async {
    try {
      _sementes = await _sementeService.listarSementes();
      notifyListeners();
    } catch (e) {
      print('Error fetching todos: $e');
    }
  }
}
