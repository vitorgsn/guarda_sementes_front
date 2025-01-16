import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/authentication_model.dart';

class AuthenticationService {
  final String baseUrl = 'http://191.7.87.244:19999/api/usuarios';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Login
  Future<AuthenticationModel?> login(String usuario, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/autenticar'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json', // Adicionando o cabeçalho Accept
      },
      body: json.encode({'login': usuario, 'senha': senha}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = AuthenticationModel.fromJson(data);
      // Armazenar o token de acesso de forma segura
      await _secureStorage.write(key: 'token', value: token.token);
      return token;
    } else {
      print('Erro: ${response.statusCode}');
      print('Mensagem: ${response.body}');
      throw Exception('Falha na autenticação: ${response.body}');
    }
  }

  // Logout
  Future<void> logout() async {
    await _secureStorage.delete(key: 'token');
  }

  // Verifica se o usuário está autenticado
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: 'token');
    return token != null;
  }
}
