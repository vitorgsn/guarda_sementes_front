import 'dart:convert';
import 'package:guarda_sementes_front/src/models/semente_disponivel_troca_model.dart';
import 'package:http/http.dart' as http;

class SementeDisponivelTrocaService {
  final String baseUrl =
      'http://191.7.87.244:19999/api/sementes-disponiveis-troca'; // URL base da API

  // Método para buscar as sementes disponíveis
  Future<List<SementeDisponivelTrocaModel>>
      listarSementesDisponiveisParaTroca() async {
    try {
      // Construir a URL completa com parâmetros de query
      final url = Uri.parse(
          '$baseUrl?size=10&page=0&sort=sdt_nr_id,asc&sdtTxObservacoes=');
      // Realiza a requisição GET para a API
      final response = await http.get(url);
      // Verifica se a resposta foi bem-sucedida (status code 200)
      if (response.statusCode == 200) {
        try {
          // Decodifica a resposta JSON
          Map<String, dynamic> data = json.decode(response.body);

          // Acesse o campo 'content' da resposta e mapeie os dados para uma lista de objetos Semente
          List<dynamic> content = data['content'];
          List<SementeDisponivelTrocaModel> sementes = content
              .map((json) => SementeDisponivelTrocaModel.fromJson(json))
              .toList();

          return sementes;
        } catch (e) {
          throw Exception('Falha ao converter sementes: $e');
        }
      } else {
        throw Exception('Falha ao carregar sementes');
      }
    } catch (e) {
      // Em caso de erro, lança uma exceção
      throw Exception('Erro ao buscar sementes: $e');
    }
  }
}
