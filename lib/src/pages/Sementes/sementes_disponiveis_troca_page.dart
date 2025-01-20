import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/Trocas/escolher_semente_troca_page.dart';
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
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final semente = listaFiltrada[index];
                return ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipOval(
                      child: Image.asset(
                        semente.icone,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    semente.semTxNome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${semente.cidTxNome} - ${semente.estTxSigla}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        semente.sdtTxObservacoes,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '${semente.sdtNrQuantidade} kg',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                );
              },
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, __) => const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              itemCount: listaFiltrada.length,
            ),
          ),
        ],
      ),
    );
  }
}
