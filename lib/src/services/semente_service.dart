import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:http/http.dart' as http;

class SementeService {
  final String baseUrl = 'http://localhost:5786/api/sementes';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<Semente>> listarSementes({Map<String, dynamic>? filtros}) async {
    try {
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
        List<dynamic> sementesJson = jsonResponse['content'];
        return sementesJson
            .map((semente) => Semente.fromJson(semente))
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

  Future<Semente?> criarSemente(Semente semente) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse(baseUrl);

      final response = await http.post(uri,
          headers: headers, body: json.encode(semente.toJson()));

      if (response.statusCode == 201) {
        return Semente.fromJson(json.decode(response.body));
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

  Future<Semente?> atualizarSemente(Semente semente) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/${semente.semNrId}');

      final response = await http.put(
        uri,
        headers: headers,
        body: json.encode(semente.toJson()),
      );

      if (response.statusCode == 201) {
        return Semente.fromJson(json.decode(response.body));
      } else {
        throw 'Falha ao atualizar a semente';
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera da conexão excedido. Tente novamente.';
    } catch (e) {
      throw ('Erro ao processar, contate o suporte');
    }
  }

  Future<Semente?> buscarSementePorId(int semNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$semNrId');
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        return Semente.fromJson(json.decode(decodedBody));
      } else {
        throw 'Falha ao buscar a semente. Código: ${response.statusCode}';
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw 'Erro ao processar a requisição: $e';
    }
  }

  Future<void> excluirSemente(int semNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$semNrId');
      final response = await http.delete(uri, headers: headers);

      if (response.statusCode != 204) {
        throw response.body;
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw 'Erro ao excluir o endereço: $e';
    }
  }
}
