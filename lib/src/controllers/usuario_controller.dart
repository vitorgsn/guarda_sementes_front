import 'package:flutter/foundation.dart';
import 'package:guarda_sementes_front/src/models/usuario.dart';
import 'package:guarda_sementes_front/src/services/usuario_service.dart';

class UsuarioController with ChangeNotifier {
  final UsuarioService _usuarioService = UsuarioService();
  Usuario? _usuario;
  Usuario? get usuario => _usuario;

  Future<void> getUsuario() async {
    try {
      final usuarioAutenticado = await _usuarioService.getUsuario();
      _usuario = usuarioAutenticado;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
