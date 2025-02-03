import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/authentication_model.dart';
import 'package:guarda_sementes_front/src/services/authentication_service.dart';

class AuthenticationController extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();
  AuthenticationModel? _authenticationModel;
  AuthenticationModel? get authenticationModel => _authenticationModel;

  Future<void> login(String usuario, String senha) async {
    try {
      _authenticationModel = await _authenticationService.login(usuario, senha);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authenticationService.logout();
    _authenticationModel = null;
    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    return await _authenticationService.isAuthenticated();
  }
}
