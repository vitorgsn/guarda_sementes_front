import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/semente_disponivel_troca.dart';
import 'package:guarda_sementes_front/src/services/semente_disponivel_troca_service.dart';

class SementeDisponivelTrocaController with ChangeNotifier {
  final SementeDisponivelTrocaService _sementeDisponivelTrocaService =
      SementeDisponivelTrocaService();
  List<SementeDisponivelTroca> _sementesDispoinveisTroca = [];
  List<SementeDisponivelTroca> get sementesDispoinveisTroca =>
      _sementesDispoinveisTroca;
  bool isLoading = false;

  Future<void> listarSementesDisponiveisTroca(
      {Map<String, dynamic>? filtros}) async {
    isLoading = true;
    notifyListeners();

    try {
      _sementesDispoinveisTroca = [];
      notifyListeners();
      _sementesDispoinveisTroca = await _sementeDisponivelTrocaService
          .listarSementesDisponiveisTroca(filtros: filtros);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cadastrarSementeDisponivelTroca(
      SementeDisponivelTroca semente) async {
    try {
      final novaSemente = await _sementeDisponivelTrocaService
          .cadastrarSementeDisponivelTroca(semente);
      _sementesDispoinveisTroca.add(novaSemente!);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
