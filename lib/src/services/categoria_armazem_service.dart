import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/categoria_armazem.dart';
import 'package:http/http.dart' as http;

class CategoriaArmazemService {
  final String baseUrl = 'http://localhost:5786/api/categorias-armazem';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<CategoriaArmazem>> listarCategoriasArmazem(
      {Map<String, dynamic>? filtros}) async {
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
      List<dynamic> categoriasJson = jsonResponse['content'];
      return categoriasJson
          .map((categoria) => CategoriaArmazem.fromJson(categoria))
          .toList();
    } else {
      throw Exception('Falha ao carregar categorias');
    }
  }
}
