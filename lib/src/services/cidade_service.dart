import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/cidade.dart';
import 'package:http/http.dart' as http;

class CidadeService {
  final String baseUrl = 'http://192.168.0.104:5786/api/cidades';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<Cidade>> listarCidades({Map<String, dynamic>? filtros}) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse(baseUrl).replace(
        queryParameters:
            filtros?.map((key, value) => MapEntry(key, value.toString())),
      );

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        List<dynamic> cidadesJson = jsonResponse['content'];
        return cidadesJson.map((cidade) => Cidade.fromJson(cidade)).toList();
      } else {
        throw response.body;
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera da conexão excedido. Tente novamente.';
    } catch (e) {
      throw (e.toString());
    }
  }
}
