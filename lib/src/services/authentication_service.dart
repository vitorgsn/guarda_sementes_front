import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/authentication_model.dart';

class AuthenticationService {
  final String baseUrl = 'http://192.168.0.104:5786/api/usuarios';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<AuthenticationModel?> login(String usuario, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/autenticar'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'login': usuario, 'senha': senha}),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = AuthenticationModel.fromJson(data);
        await _secureStorage.write(key: 'token', value: token.token);
        return token;
      } else if (response.statusCode == 401 || response.statusCode == 500) {
        throw ('Usuário ou Senha incorretos.');
      } else {
        throw ('Falha ao autenticar. Por favor, tente novamente mais tarde.');
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera da conexão excedido. Tente novamente.';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'token');
  }

  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: 'token');
    return token != null;
  }
}
