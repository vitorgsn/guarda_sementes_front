import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/semente_disponivel_troca.dart';
import 'package:guarda_sementes_front/src/services/semente_disponivel_troca_service.dart';

class SementeDisponivelTrocaController with ChangeNotifier {
  final SementeDisponivelTrocaService _sementeService =
      SementeDisponivelTrocaService();
  List<SementeDisponivelTroca> _sementes = [];
  List<SementeDisponivelTroca> get sementes => _sementes;

  Future<void> listarSementesDisponiveisTroca(
      {Map<String, dynamic>? filtros}) async {
    try {
      _sementes = [];
      notifyListeners();
      _sementes = await _sementeService.listarSementesDisponiveisTroca(
          filtros: filtros);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
