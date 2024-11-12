import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/authentication_model.dart';
import 'package:guarda_sementes_front/src/services/authentication_service.dart';

class AuthenticationController extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();
  AuthenticationModel? _authenticationModel;

  AuthenticationModel? get authenticationModel => _authenticationModel;

  // Tenta fazer login
  Future<void> login(String email, String password) async {
    try {
      _authenticationModel =
          await _authenticationService.login(email, password);
      debugPrint(authenticationModel.toString());
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao autenticar: $e');
    }
  }

  // Faz logout
  Future<void> logout() async {
    await _authenticationService.logout();
    _authenticationModel = null;
    notifyListeners();
  }

  // Verifica se o usuário está autenticado
  Future<bool> isAuthenticated() async {
    return await _authenticationService.isAuthenticated();
  }
}
