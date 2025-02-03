import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/endereco.dart';
import 'package:guarda_sementes_front/src/services/endereco_service.dart';

class EnderecoController with ChangeNotifier {
  final EnderecoService _enderecoService = EnderecoService();
  List<Endereco> _enderecos = [];
  List<Endereco> get enderecos => _enderecos;

  Future<void> listarEnderecos({Map<String, dynamic>? filtros}) async {
    try {
      _enderecos = await _enderecoService.listarEnderecos(filtros: filtros);
      notifyListeners();
    } catch (e) {
      print('Erro ao listar os endreços');
    }
  }

  Future<void> criarEndreco(Endereco endereco) async {
    try {
      final novoEndereco = await _enderecoService.criarEndereco(endereco);
      _enderecos.add(novoEndereco!);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
