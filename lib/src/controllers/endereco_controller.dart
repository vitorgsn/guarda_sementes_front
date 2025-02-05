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
      rethrow;
    }
  }

  Future<void> criarEndereco(Endereco endereco) async {
    try {
      final novoEndereco = await _enderecoService.criarEndereco(endereco);
      _enderecos.add(novoEndereco!);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarEndereco(Endereco endereco) async {
    try {
      final enderecoAtualizado =
          await _enderecoService.atualizarEndereco(endereco);
      final index = _enderecos.indexWhere((e) => e.endNrId == endereco.endNrId);
      if (index != -1) {
        _enderecos[index] = enderecoAtualizado!;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Endereco?> buscarEnderecoPorId(int endNrId) async {
    try {
      final endereco = await _enderecoService.buscarEnderecoPorId(endNrId);

      if (endereco != null) {
        final index = _enderecos.indexWhere((e) => e.endNrId == endNrId);

        if (index != -1) {
          _enderecos[index] = endereco;
        } else {
          _enderecos.add(endereco);
        }

        notifyListeners();
      }

      return endereco;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> excluirEndereco(int endNrId) async {
    try {
      await _enderecoService.excluirEndereco(endNrId);
      _enderecos.removeWhere((e) => e.endNrId == endNrId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
