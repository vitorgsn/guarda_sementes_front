import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/semente/escolher_semente_troca_page.dart';
import 'package:guarda_sementes_front/src/repositories/semente_disponivel_troca_teste_repository.dart';

class SementesDisponiveisTrocaPage extends StatefulWidget {
  const SementesDisponiveisTrocaPage({super.key});

  @override
  State<SementesDisponiveisTrocaPage> createState() =>
      _SementesDisponiveisTrocaPageState();
}

class _SementesDisponiveisTrocaPageState
    extends State<SementesDisponiveisTrocaPage> {
  final tabela = SementeDisponivelTrocaTesteRepository.tabela;
  List<dynamic> listaFiltrada = [];
  String termoBusca = '';

  @override
  void initState() {
    super.initState();
    listaFiltrada = tabela; // Inicialmente, exibir toda a lista.
  }

  void atualizarBusca(String valor) {
    setState(() {
      termoBusca = valor.toLowerCase();
      listaFiltrada = tabela.where((semente) {
        final nomeSemente = semente.semTxNome.toLowerCase();
        final cidade = semente.cidTxNome.toLowerCase();
        final descricao = semente.sdtTxObservacoes.toLowerCase();
        return nomeSemente.contains(termoBusca) ||
            cidade.contains(termoBusca) ||
            descricao.contains(termoBusca);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FEIRA DE TROCAS'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: atualizarBusca,
              decoration: InputDecoration(
                labelText: 'Buscar',
                hintText: 'Nome, Cidade ou Descrição',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                  borderSide: const BorderSide(
                    color: Colors.grey, // Cor da borda
                    width: 1, // Largura da borda
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.grey, // Cor da borda quando habilitado
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.grey, // Cor da borda ao focar
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final semente = listaFiltrada[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EscolherSementeTrocaPage(
                            sementeSelecionada:
                                semente, // Passar a semente clicada para a nova página
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Card com bordas mais arredondadas
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // Padding reduzido
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Container(
                                width: 70, // Aumento do tamanho da imagem
                                height: 70,
                                color: Colors.green[100],
                                child: const Icon(
                                  Icons.grain,
                                  color: Colors.green,
                                  size: 48, // Ícone maior
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              semente.semTxNome,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${semente.cidTxNome} - ${semente.estTxSigla}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              semente.sdtTxObservacoes,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${semente.sdtNrQuantidade} kg',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: listaFiltrada.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
