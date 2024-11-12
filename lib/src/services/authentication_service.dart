import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/authentication_model.dart';

class AuthenticationService {
  final String baseUrl = 'http://191.7.87.244:19999/api/auth';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Login
  Future<AuthenticationModel?> login(String email, String password) async {
    print('$baseUrl/login');
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json', // Adicionando o cabeçalho Accept
      },
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      print('Resposta da API: ${response.body}'); // Verifique o que é retornado
      final data = json.decode(response.body);
      final token = AuthenticationModel.fromJson(data);
      // Armazenar o token de acesso de forma segura
      await _secureStorage.write(key: 'access_token', value: token.accessToken);
      return token;
    } else {
      print('Erro: ${response.statusCode}');
      print('Mensagem: ${response.body}');
      throw Exception('Falha na autenticação: ${response.body}');
    }
  }

  // Logout
  Future<void> logout() async {
    await _secureStorage.delete(key: 'access_token');
  }

  // Verifica se o usuário está autenticado
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null;
  }
}
