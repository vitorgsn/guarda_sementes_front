import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/models/semente_disponivel_troca_model.dart';
import 'package:guarda_sementes_front/src/services/semente_disponivel_troca_service.dart';

class SementeDisponivelTrocaController extends ChangeNotifier {
  final SementeDisponivelTrocaService _sementeDisponivelTrocaService =
      SementeDisponivelTrocaService();
  List<SementeDisponivelTrocaModel> _sementes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<SementeDisponivelTrocaModel> get sementes => _sementes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Método para buscar as sementes
  Future<void> listarSementesDisponiveisParaTroca() async {
    _isLoading = true;
    notifyListeners(); // Notifica que o estado mudou (carregamento)

    try {
      _sementes = await _sementeDisponivelTrocaService
          .listarSementesDisponiveisParaTroca();
      _errorMessage = ''; // Limpa a mensagem de erro, se houver
    } catch (e) {
      _errorMessage = e.toString(); // Armazena a mensagem de erro
    }

    _isLoading = false;
    notifyListeners(); // Notifica que o carregamento foi concluído
  }
}
