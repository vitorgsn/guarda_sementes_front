import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/endereco.dart';
import 'package:http/http.dart' as http;

class EnderecoService {
  final String baseUrl = 'http://192.168.0.104:5786/api/enderecos';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<Endereco>> listarEnderecos(
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
        List<dynamic> enderecosJson = jsonResponse['content'];
        return enderecosJson
            .map((endereco) => Endereco.fromJson(endereco))
            .toList();
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

  Future<Endereco?> criarEndereco(Endereco endereco) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse(baseUrl);

      final response = await http.post(uri,
          headers: headers, body: json.encode(endereco.toJson()));

      if (response.statusCode == 201) {
        return Endereco.fromJson(json.decode(response.body));
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

  Future<Endereco?> atualizarEndereco(Endereco endereco) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/${endereco.endNrId}');

      final response = await http.put(
        uri,
        headers: headers,
        body: json.encode(endereco.toJson()),
      );

      if (response.statusCode == 201) {
        return Endereco.fromJson(json.decode(response.body));
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

  Future<Endereco?> buscarEnderecoPorId(int endNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$endNrId');
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        return Endereco.fromJson(json.decode(decodedBody));
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

  Future<void> excluirEndereco(int endNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$endNrId');
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
}
