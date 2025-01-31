import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/semente_disponivel_troca.dart';
import 'package:http/http.dart' as http;

class SementeDisponivelTrocaService {
  final String baseUrl = 'http://localhost:5786/api/sementes-disponiveis-troca';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<SementeDisponivelTroca>> listarSementesDisponiveisTroca(
      {Map<String, dynamic>? filtros}) async {
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
        List<dynamic> sementesDisponiveisJson = jsonResponse['content'];
        return sementesDisponiveisJson
            .map((semente) => SementeDisponivelTroca.fromJson(semente))
            .toList();
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
