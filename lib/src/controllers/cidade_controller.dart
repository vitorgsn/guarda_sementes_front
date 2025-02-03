import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/cidade.dart';
import 'package:guarda_sementes_front/src/services/cidade_service.dart';

class CidadeController with ChangeNotifier {
  final CidadeService _cidadeService = CidadeService();
  List<Cidade> _cidades = [];
  List<Cidade> get cidades => _cidades;

  // Alteração: garante que sempre haverá um retorno válido
  Future<List<Cidade>> listarCidades({Map<String, dynamic>? filtros}) async {
    try {
      _cidades = await _cidadeService.listarCidades(filtros: filtros);
      notifyListeners();
      return _cidades; // Retorna a lista de cidades
    } catch (e) {
      print('Erro ao listar as cidades: $e');
      throw Exception(
          'Erro ao listar as cidades: $e'); // Garante que a exceção é lançada
    }
  }
}
