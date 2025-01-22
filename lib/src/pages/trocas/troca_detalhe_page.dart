import 'package:flutter/material.dart';

class TrocaDetalhePage extends StatefulWidget {
  final Map<String, String> troca;

  const TrocaDetalhePage({super.key, required this.troca});

  @override
  State<TrocaDetalhePage> createState() => _TrocaDetalhePageState();
}

class _TrocaDetalhePageState extends State<TrocaDetalhePage> {
  @override
  Widget build(BuildContext context) {
    final String status = widget.troca['sttTxStatus'] ?? 'Indefinido';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Troca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remetente: ${widget.troca['usuTxNomeRemetente']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Semente: ${widget.troca['semTxNomeRemetente']} - ${widget.troca['semNrQuantidadeRemetente']} kg',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Destinatário: ${widget.troca['usuTxNomeDestinatario']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Semente: ${widget.troca['semTxNomeDestinatario']} - ${widget.troca['semNrQuantidadeDestinatario']} kg',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Status: $status',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Data: ${widget.troca['sttDtStatusTroca']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Instruções: ${widget.troca['troTxInstrucoes']}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            if (status == 'Pendente') ...[
              const Text(
                'Ações Disponíveis:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implementar lógica para aceitar troca
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Troca aceita!')),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Aceitar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implementar lógica para recusar troca
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Troca recusada!')),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Recusar',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implementar lógica para cancelar troca
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Troca cancelada!')),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
