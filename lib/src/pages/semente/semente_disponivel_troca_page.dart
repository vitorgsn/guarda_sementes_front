import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/semente_disponivel_troca_controller.dart';
import 'package:guarda_sementes_front/src/pages/semente/escolher_semente_troca_page.dart';
import 'package:provider/provider.dart';

class SementeDisponivelTrocaPage extends StatefulWidget {
  const SementeDisponivelTrocaPage({super.key});

  @override
  State<SementeDisponivelTrocaPage> createState() =>
      _SementeDisponivelTrocaPageState();
}

class _SementeDisponivelTrocaPageState
    extends State<SementeDisponivelTrocaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarSementesDisponiveis();
    });
  }

  Future<void> _carregarSementesDisponiveis() async {
    final sementeDisponivelTrocaController =
        Provider.of<SementeDisponivelTrocaController>(context, listen: false);
    await sementeDisponivelTrocaController.listarSementesDisponiveisTroca(
      filtros: {'sort': 'sdt_nr_id,desc'},
    );
  }

  void atualizarBusca(String valor) {
    final controller =
        Provider.of<SementeDisponivelTrocaController>(context, listen: false);

    controller.listarSementesDisponiveisTroca(
      filtros: {
        'semTxNome': valor,
        'sdtTxObservacoes': valor,
        'cidTxNome': valor,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sementeDisponivelTrocaController =
        Provider.of<SementeDisponivelTrocaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feira de Trocas'),
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
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 32, 17, 17), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
          ),
          sementeDisponivelTrocaController.isLoading
              ? _buildLoading()
              : sementeDisponivelTrocaController
                      .sementesDispoinveisTroca.isEmpty
                  ? _buildSemSementes()
                  : _buildGrid(sementeDisponivelTrocaController),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSemSementes() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nenhuma semente encontrada.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(
      SementeDisponivelTrocaController sementeDisponivelTrocaController) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount:
              sementeDisponivelTrocaController.sementesDispoinveisTroca.length,
          itemBuilder: (BuildContext context, int index) {
            final semente = sementeDisponivelTrocaController
                .sementesDispoinveisTroca[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EscolherSementeTrocaPage(
                      sementeSelecionada: semente,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.green[100],
                          child: const Icon(
                            Icons.grain,
                            color: Colors.green,
                            size: 32,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        semente.semTxNome!,
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
        ),
      ),
    );
  }
}
