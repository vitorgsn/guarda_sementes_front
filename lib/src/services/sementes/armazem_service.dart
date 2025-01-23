import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/sementes/armazem.dart';
import 'package:http/http.dart' as http;

class ArmazemService {
  final String baseUrl = 'http://191.7.87.244:19999/api/armazens';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<Armazem>> listarArmazens({Map<String, dynamic>? filtros}) async {
    // Recupera o token
    token = (await _storage.read(key: 'token'))!;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // Construa a URL com os filtros
    final uri = Uri.parse(baseUrl).replace(
      queryParameters:
          filtros?.map((key, value) => MapEntry(key, value.toString())),
    );

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      List<dynamic> armanesJson = jsonResponse['content'];
      return armanesJson.map((armazem) => Armazem.fromJson(armazem)).toList();
    } else {
      throw Exception('Falha ao carregar armazens');
    }
  }

  Future<Armazem?> criarArmazem(Armazem armazem) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse(baseUrl);

      final response = await http.post(uri,
          headers: headers, body: json.encode(armazem.toJson()));

      if (response.statusCode == 201) {
        return Armazem.fromJson(json.decode(response.body));
      } else {
        throw (response.body);
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera da conexão excedido. Tente novamente.';
    } catch (e) {
      throw ('Erro ao processar, contate o suporte');
    }
  }
}
