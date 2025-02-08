import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/semente_controller.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:provider/provider.dart';

class EscolherSementeTrocaPage extends StatefulWidget {
  final dynamic sementeSelecionada;

  const EscolherSementeTrocaPage({super.key, required this.sementeSelecionada});

  @override
  State<EscolherSementeTrocaPage> createState() =>
      _EscolherSementeTrocaPageState();
}

class _EscolherSementeTrocaPageState extends State<EscolherSementeTrocaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarSementes();
    });
  }

  Future<void> _carregarSementes() async {
    final sementeController =
        Provider.of<SementeController>(context, listen: false);
    await sementeController.listarSementes(filtros: {
      'sort': 'sem_nr_id,desc',
    });
  }

  void atualizarBusca(String valor) {
    final sementeController =
        Provider.of<SementeController>(context, listen: false);

    sementeController.listarSementes(
      filtros: {
        'semTxNome': valor,
      },
    );
  }

  void abrirJanelaTroca(BuildContext context, Semente semente) {
    int quantidadeSelecionada = 1; // Quantidade inicial selecionada
    final TextEditingController instrucoesController =
        TextEditingController(); // Controlador para as instruções

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Permite rolar se necessário
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Trocar ${semente.semTxNome} pela ${widget.sementeSelecionada.semTxNome}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Selecione a quantidade para a troca:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: quantidadeSelecionada > 1
                        ? () {
                            setState(() {
                              quantidadeSelecionada--;
                            });
                          }
                        : null,
                  ),
                  Text(
                    '$quantidadeSelecionada',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: quantidadeSelecionada < semente.semNrQuantidade
                        ? () {
                            setState(() {
                              quantidadeSelecionada++;
                            });
                          }
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: instrucoesController,
                decoration: const InputDecoration(
                  labelText: 'Instruções de troca',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3, // Permite até 3 linhas de texto
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Confirmar a troca com a quantidade selecionada e as instruções
                  print(
                      'Confirmado: Trocar $quantidadeSelecionada de ${semente.semTxNome} pela ${widget.sementeSelecionada.semTxNome}');
                  print(
                      'Instruções fornecidas: ${instrucoesController.text.trim()}');
                  Navigator.pop(context); // Fechar a janela
                },
                child: const Text('Propor Troca'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sementeController = Provider.of<SementeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trocar por ${widget.sementeSelecionada.semTxNome}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: atualizarBusca,
              decoration: InputDecoration(
                labelText: 'Buscar',
                hintText: 'Nome',
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
          sementeController.isLoading
              ? _buildLoading()
              : sementeController.sementes.isEmpty
                  ? _buildSemSementes()
                  : _buildGrid(sementeController),
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
            'Você não possui sementes cadastradas, para efetuar uma troca é necessário ter sementes para ofertar.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(SementeController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListView.builder(
          itemCount: controller.sementes.length,
          itemBuilder: (context, index) {
            final semente = controller.sementes[index];
            return ListTile(
              leading: const Icon(Icons.grain),
              title: Text(semente.semTxNome),
              subtitle: Text('Quantidade: ${semente.semNrQuantidade}'),
              trailing: ElevatedButton(
                onPressed: () => abrirJanelaTroca(context, semente),
                child: const Text('Trocar'),
              ),
            );
          },
        ),
      ),
    );
  }
}
