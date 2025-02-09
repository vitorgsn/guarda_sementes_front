import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/contato.dart';
import 'package:guarda_sementes_front/src/services/contato_service.dart';

class ContatoController with ChangeNotifier {
  final ContatoService _contatoService = ContatoService();
  List<Contato> _contatos = [];
  List<Contato> get contatos => _contatos;

  Future<void> listarContatos({Map<String, dynamic>? filtros}) async {
    try {
      _contatos = await _contatoService.listarContatos(filtros: filtros);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> criarContato(Contato contato) async {
    try {
      final novoContato = await _contatoService.criarContato(contato);
      _contatos.add(novoContato!);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarContato(Contato contato) async {
    try {
      final contatoAtualizado = await _contatoService.atualizarContato(contato);
      final index = _contatos.indexWhere((e) => e.conNrId == contato.conNrId);
      if (index != -1) {
        _contatos[index] = contatoAtualizado!;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Contato?> buscarContatoPorId(int conNrId) async {
    try {
      final contato = await _contatoService.buscarContatoPorId(conNrId);

      if (contato != null) {
        final index = _contatos.indexWhere((e) => e.conNrId == conNrId);

        if (index != -1) {
          _contatos[index] = contato;
        } else {
          _contatos.add(contato);
        }

        notifyListeners();
      }

      return contato;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> excluirContato(int conNrId) async {
    try {
      await _contatoService.excluirContato(conNrId);
      _contatos.removeWhere((e) => e.conNrId == conNrId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
