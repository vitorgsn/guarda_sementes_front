import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/cidade.dart';
import 'package:guarda_sementes_front/src/services/cidade_service.dart';

class CidadeController with ChangeNotifier {
  final CidadeService _cidadeService = CidadeService();
  List<Cidade> _cidades = [];
  List<Cidade> get cidades => _cidades;

  Future<List<Cidade>> listarCidades({Map<String, dynamic>? filtros}) async {
    try {
      _cidades = await _cidadeService.listarCidades(filtros: filtros);
      notifyListeners();
      return _cidades;
    } catch (e) {
      rethrow;
    }
  }
}
