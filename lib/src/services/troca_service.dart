import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/troca.dart';
import 'package:http/http.dart' as http;

class TrocaService {
  final String baseUrl = 'http://192.168.0.104:5786/api/trocas';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<Troca>> listarTrocas({Map<String, dynamic>? filtros}) async {
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
        List<dynamic> trocasJson = jsonResponse['content'];
        return trocasJson.map((troca) => Troca.fromJson(troca)).toList();
      } else {
        throw (response.body);
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<Troca?> criarTroca(Troca troca) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse(baseUrl);

      final response = await http.post(uri,
          headers: headers, body: json.encode(troca.toJson()));

      if (response.statusCode == 201) {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        return Troca.fromJson(jsonResponse);
      } else {
        throw response.body;
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw (e.toString());
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
        throw response.body;
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw (e.toString());
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
        throw response.body;
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> aceitarTroca(String troNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$troNrId/aceitar');
      final response = await http.post(uri, headers: headers);

      if (response.statusCode != 204) {
        throw response.body;
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> recusarTroca(String troNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$troNrId/recusar');
      final response = await http.post(uri, headers: headers);

      if (response.statusCode != 204) {
        throw response.body;
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> cancelarTroca(String troNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$troNrId/cancelar');
      final response = await http.post(uri, headers: headers);

      if (response.statusCode != 204) {
        throw response.body;
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw (e.toString());
    }
  }
}
