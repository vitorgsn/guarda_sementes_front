import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/troca_controller.dart';
import 'package:guarda_sementes_front/src/pages/troca/troca_detalhe_page.dart';
import 'package:provider/provider.dart';

class TrocaPage extends StatefulWidget {
  const TrocaPage({super.key});

  @override
  State<TrocaPage> createState() => _TrocaPageState();
}

class _TrocaPageState extends State<TrocaPage> {
  String? statusSelecionado = 'PENDENTE';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarTrocas();
    });
  }

  Future<void> _carregarTrocas() async {
    final trocaController =
        Provider.of<TrocaController>(context, listen: false);
    await trocaController.listarTrocas(filtros: {
      'sort': 'tro_nr_id,desc',
      'sttTxStatus': statusSelecionado,
    });
  }

  void atualizarBusca() {
    final trocaController =
        Provider.of<TrocaController>(context, listen: false);

    trocaController.listarTrocas(
      filtros: {
        'sttTxStatus': statusSelecionado,
      },
    );
  }

  void selecionarStatus(String status) {
    setState(() {
      statusSelecionado = status;
    });

    atualizarBusca();
  }

  @override
  Widget build(BuildContext context) {
    final trocaController = Provider.of<TrocaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Trocas'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          statusSelecionado == 'PENDENTE'
                              ? Icons.access_time_filled
                              : Icons.access_time,
                          color: Colors.orange,
                          size: 50,
                        ),
                        onPressed: () {
                          selecionarStatus('PENDENTE');
                        },
                      ),
                      const Text('Pendente',
                          style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          statusSelecionado == 'CONCLUIDA'
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: Colors.green,
                          size: 50,
                        ),
                        onPressed: () {
                          selecionarStatus('CONCLUIDA');
                        },
                      ),
                      const Text('Concluída',
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          statusSelecionado == 'RECUSADA'
                              ? Icons.cancel
                              : Icons.cancel_outlined,
                          color: Colors.red,
                          size: 50,
                        ),
                        onPressed: () {
                          selecionarStatus('RECUSADA');
                        },
                      ),
                      const Text('Recusada',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          statusSelecionado == 'CANCELADA'
                              ? Icons.remove_circle
                              : Icons.remove_circle_outline,
                          color: Colors.grey,
                          size: 50,
                        ),
                        onPressed: () {
                          selecionarStatus('CANCELADA');
                        },
                      ),
                      const Text('Cancelada',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          trocaController.isLoading
              ? _buildLoading()
              : trocaController.trocas.isEmpty
                  ? _buildSemTrocas()
                  : _buildList(trocaController),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSemTrocas() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nenhuma troca $statusSelecionado encontrada.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(TrocaController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListView.builder(
          itemCount: controller.trocas.length,
          itemBuilder: (context, index) {
            final troca = controller.trocas[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrocaDetalhePage(troca: troca),
                    ),
                  ).then((_) {
                    _carregarTrocas();
                  });
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${troca.troNrId}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.download,
                          color: Colors.red,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '${troca.usuTxNomeRemetente} ofertou ${troca.semTxNomeRemetente} - ${troca.troNrQuantidadeSementeRemetente} kg',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.upload,
                          color: Colors.green,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '${troca.usuTxNomeDestinatario} ofertou ${troca.semTxNomeDestinatario} - ${troca.troNrQuantidadeSementeDestinatario} kg',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range_outlined,
                          color: Colors.lightBlue,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${troca.sttDtStatusTroca}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          troca.troTxInstrucoes,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
