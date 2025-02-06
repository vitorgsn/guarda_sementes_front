import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/contato.dart';
import 'package:http/http.dart' as http;

class ContatoService {
  final String baseUrl = 'http://192.168.0.104:5786/api/contatos';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<Contato>> listarContatos({Map<String, dynamic>? filtros}) async {
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
      List<dynamic> contatosJson = jsonResponse['content'];
      return contatosJson.map((contato) => Contato.fromJson(contato)).toList();
    } else {
      throw Exception('Falha ao carregar contatos');
    }
  }

  Future<Contato?> criarContato(Contato contato) async {
    print(contato.toString());
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse(baseUrl);

      final response = await http.post(uri,
          headers: headers, body: json.encode(contato.toJson()));

      print(response.statusCode);

      if (response.statusCode == 201) {
        return Contato.fromJson(json.decode(response.body));
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

  Future<Contato?> atualizarContato(Contato contato) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/${contato.conNrId}');

      final response = await http.put(
        uri,
        headers: headers,
        body: json.encode(contato.toJson()),
      );

      if (response.statusCode == 201) {
        return Contato.fromJson(json.decode(response.body));
      } else {
        throw 'Falha ao atualizar o contato';
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera da conexão excedido. Tente novamente.';
    } catch (e) {
      throw ('Erro ao processar, contate o suporte');
    }
  }

  Future<Contato?> buscarContatoPorId(int conNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$conNrId');
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        return Contato.fromJson(json.decode(decodedBody));
      } else {
        throw 'Falha ao buscar o contato. Código: ${response.statusCode}';
      }
    } on http.ClientException {
      throw 'Servidor offline. Tente novamente mais tarde.';
    } on TimeoutException {
      throw 'Tempo de espera excedido. Tente novamente.';
    } catch (e) {
      throw 'Erro ao processar a requisição: $e';
    }
  }

  Future<void> excluirContato(int conNrId) async {
    try {
      token = (await _storage.read(key: 'token'))!;
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final uri = Uri.parse('$baseUrl/$conNrId');
      final response = await http.delete(uri, headers: headers);

      if (response.statusCode != 204) {
        throw 'Falha ao excluir o contato. Código: ${response.statusCode}';
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
