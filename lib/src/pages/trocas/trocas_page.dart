import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/trocas/troca_detalhe_page.dart';

class TrocasPage extends StatefulWidget {
  const TrocasPage({super.key});

  @override
  _TrocasPageState createState() => _TrocasPageState();
}

class _TrocasPageState extends State<TrocasPage> {
  // Status selecionado, por padrão, nenhum status está selecionado
  String? statusSelecionado = 'Pendente';

  // Lista de trocas fictícias (em um cenário real, isso viria da API)
  final List<Map<String, String>> trocas = [
    {
      "usuNrIdRemetente": "1",
      "usuTxNomeRemetente": "Vitor",
      "semTxNomeRemetente": "Feijão fradinho",
      "semNrQuantidadeRemetente": "10",
      "usuNrIdDestinatario": "2",
      "usuTxNomeDestinatario": "João",
      "semTxNomeDestinatario": "Milho Vermelho",
      "semNrQuantidadeDestinatario": "15",
      "troNrId": "7e5eb365-3803-4eb5-a240-924eb3d2ee2a",
      "troTxInstrucoes": "Na rodoviária de Lagarto",
      "sttDtStatusTroca": "2024-12-28",
      "sttTxStatus": "Pendente"
    },
    {
      "usuNrIdRemetente": "1",
      "usuTxNomeRemetente": "João",
      "semTxNomeRemetente": "Feijão fradinho",
      "semNrQuantidadeRemetente": "10",
      "usuNrIdDestinatario": "2",
      "usuTxNomeDestinatario": "Vitor",
      "semTxNomeDestinatario": "Milho Vermelho",
      "semNrQuantidadeDestinatario": "15",
      "troNrId": "7e5eb365-3803-4eb5-a240-924eb3d2ee2a",
      "troTxInstrucoes": "Na rodoviária de Lagarto",
      "sttDtStatusTroca": "2024-12-28",
      "sttTxStatus": "Pendente"
    },
    {
      "usuNrIdRemetente": "1",
      "usuTxNomeRemetente": "Vitor",
      "semTxNomeRemetente": "Feijão fradinho",
      "semNrQuantidadeRemetente": "10",
      "usuNrIdDestinatario": "2",
      "usuTxNomeDestinatario": "João",
      "semTxNomeDestinatario": "Milho Vermelho",
      "semNrQuantidadeDestinatario": "15",
      "troNrId": "7e5eb365-3803-4eb5-a240-924eb3d2ee2a",
      "troTxInstrucoes": "Na rodoviária de Lagarto",
      "sttDtStatusTroca": "2024-12-28",
      "sttTxStatus": "Concluída"
    },
    {
      "usuNrIdRemetente": "1",
      "usuTxNomeRemetente": "Vitor",
      "semTxNomeRemetente": "Feijão fradinho",
      "semNrQuantidadeRemetente": "10",
      "usuNrIdDestinatario": "2",
      "usuTxNomeDestinatario": "João",
      "semTxNomeDestinatario": "Milho Vermelho",
      "semNrQuantidadeDestinatario": "15",
      "troNrId": "7e5eb365-3803-4eb5-a240-924eb3d2ee2a",
      "troTxInstrucoes": "Na rodoviária de Lagarto",
      "sttDtStatusTroca": "2024-12-28",
      "sttTxStatus": "Recusada"
    },
    {
      "usuNrIdRemetente": "1",
      "usuTxNomeRemetente": "João",
      "semTxNomeRemetente": "Feijão fradinho",
      "semNrQuantidadeRemetente": "10",
      "usuNrIdDestinatario": "2",
      "usuTxNomeDestinatario": "Vitor",
      "semTxNomeDestinatario": "Milho Vermelho",
      "semNrQuantidadeDestinatario": "15",
      "troNrId": "7e5eb365-3803-4eb5-a240-924eb3d2ee2a",
      "troTxInstrucoes": "Na rodoviária de Lagarto",
      "sttDtStatusTroca": "2024-12-28",
      "sttTxStatus": "Cancelada"
    },
  ];

  // Método para filtrar trocas com base no status
  List<Map<String, String>> getTrocasFiltradas() {
    if (statusSelecionado == null) {
      return trocas; // Se nenhum status estiver selecionado, retorna todas as trocas
    }
    return trocas
        .where((troca) => troca['sttTxStatus'] == statusSelecionado)
        .toList();
  }

  // Método para alterar o status selecionado
  void selecionarStatus(String status) {
    setState(() {
      if (statusSelecionado == status) {
        // Se o status já estiver selecionado, desmarque ele
        statusSelecionado = null;
      } else {
        // Caso contrário, marque o novo status
        statusSelecionado = status;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MINHAS TROCAS'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Primeira linha de ícones (botões)
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Ícone de "Pendente"
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        statusSelecionado == 'Pendente'
                            ? Icons.access_time_filled
                            : Icons.access_time,
                        color: Colors.orange,
                        size: 50,
                      ),
                      onPressed: () {
                        selecionarStatus('Pendente');
                      },
                    ),
                    const Text('Pendente',
                        style: TextStyle(color: Colors.orange)),
                  ],
                ),

                // Ícone de "Concluída"
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        statusSelecionado == 'Concluída'
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: Colors.green,
                        size: 50,
                      ),
                      onPressed: () {
                        selecionarStatus('Concluída');
                      },
                    ),
                    const Text('Concluída',
                        style: TextStyle(color: Colors.green)),
                  ],
                ),

                // Ícone de "Recusada"
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        statusSelecionado == 'Recusada'
                            ? Icons.cancel
                            : Icons.cancel_outlined,
                        color: Colors.red,
                        size: 50,
                      ),
                      onPressed: () {
                        selecionarStatus('Recusada');
                      },
                    ),
                    const Text('Recusada', style: TextStyle(color: Colors.red)),
                  ],
                ),

                // Ícone de "Cancelada"
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        statusSelecionado == 'Cancelada'
                            ? Icons.remove_circle
                            : Icons.remove_circle_outline,
                        color: Colors.grey,
                        size: 50,
                      ),
                      onPressed: () {
                        selecionarStatus('Cancelada');
                      },
                    ),
                    const Text('Cancelada',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          // Lista de trocas filtradas
          Expanded(
            child: ListView.separated(
              itemCount: getTrocasFiltradas().length,
              itemBuilder: (context, index) {
                final troca = getTrocasFiltradas()[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrocaDetalhePage(troca: troca),
                      ),
                    );
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${troca['troNrId']}',
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
                          Text(
                            '${troca['usuTxNomeRemetente']} ofertou ${troca['semTxNomeRemetente']} - ${troca['semNrQuantidadeRemetente']} kg',
                            style: const TextStyle(
                              fontSize: 20,
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
                          Text(
                            '${troca['usuTxNomeDestinatario']} ofertou ${troca['semTxNomeDestinatario']} - ${troca['semNrQuantidadeDestinatario']} kg',
                            style: const TextStyle(
                              fontSize: 20,
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
                            '${troca['sttDtStatusTroca']}',
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
                            '${troca['troTxInstrucoes']}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, __) => const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
