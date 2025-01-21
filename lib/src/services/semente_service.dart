import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:http/http.dart' as http;

class SementeService {
  final String baseUrl = 'http://191.7.87.244:19999/api/sementes';
  var token = '';
  final _storage = const FlutterSecureStorage();

  Future<List<Semente>> listarSementes() async {
    token = (await _storage.read(key: 'token'))!;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      List<dynamic> sementesJson = jsonResponse['content'];
      return sementesJson.map((semente) => Semente.fromJson(semente)).toList();
    } else {
      throw Exception('Falha ao carregar sementes');
    }
  }
}
