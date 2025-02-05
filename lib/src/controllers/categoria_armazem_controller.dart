import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/categoria_armazem.dart';
import 'package:guarda_sementes_front/src/services/categoria_armazem_service.dart';

class CategoriaArmazemController with ChangeNotifier {
  final CategoriaArmazemService _categoriaArmazemService =
      CategoriaArmazemService();
  List<CategoriaArmazem> _categorias = [];
  List<CategoriaArmazem> get categorias => _categorias;

  Future<List<CategoriaArmazem>> listarCategoriasArmazem(
      {Map<String, dynamic>? filtros}) async {
    try {
      _categorias = await _categoriaArmazemService.listarCategoriasArmazem(
          filtros: filtros);
      notifyListeners();
      return _categorias;
    } catch (e) {
      throw Exception('Erro ao listar as categorias: $e');
    }
  }
}
