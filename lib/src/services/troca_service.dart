import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/troca.dart';
import 'package:guarda_sementes_front/src/models/troca_form.dart';
import 'package:http/http.dart' as http;

class TrocaService {
  final String baseUrl = 'http://192.168.0.104:5786/api/trocas';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<Troca>> listarTrocas({Map<String, dynamic>? filtros}) async {
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
      List<dynamic> trocasJson = jsonResponse['content'];
      return trocasJson.map((troca) => Troca.fromJson(troca)).toList();
    } else {
      throw (response.body);
    }
  }

  Future<TrocaForm?> criarTroca(TrocaForm trocaForm) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse(baseUrl);

      print(trocaForm.toString());
      print(uri);

      final response = await http.post(uri,
          headers: headers, body: json.encode(trocaForm.toJson()));

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        return TrocaForm.fromJson(json.decode(response.body));
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

  Future<Troca?> buscarTrocaPorId(String troNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$troNrId');
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        return Troca.fromJson(json.decode(decodedBody));
      } else {
        throw (response.body);
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw 'Erro ao processar a requisição: $e';
    }
  }

  Future<void> excluirTroca(String troNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$troNrId');
      final response = await http.delete(uri, headers: headers);

      if (response.statusCode != 204) {
        throw (response.body);
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw 'Erro ao excluir o requisição: $e';
    }
  }
}
