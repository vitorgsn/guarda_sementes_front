import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/troca_controller.dart';
import 'package:guarda_sementes_front/src/models/troca.dart';
import 'package:provider/provider.dart';

class TrocaDetalhePage extends StatefulWidget {
  final Troca troca;

  const TrocaDetalhePage({super.key, required this.troca});

  @override
  State<TrocaDetalhePage> createState() => _TrocaDetalhePageState();
}

class _TrocaDetalhePageState extends State<TrocaDetalhePage> {
  Future<void> _aceitarTroca() async {
    bool confirmado = await _mostrarDialogoConfirmacao("ACEITAR");
    if (confirmado) {
      try {
        final trocaController =
            Provider.of<TrocaController>(context, listen: false);
        await trocaController.aceitarTroca(widget.troca.troNrId!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              'Troca aceita com sucesso!',
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              e.toString(),
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _recusarTroca() async {
    bool confirmado = await _mostrarDialogoConfirmacao("RECUSAR");
    if (confirmado) {
      try {
        final trocaController =
            Provider.of<TrocaController>(context, listen: false);
        await trocaController.recusarTroca(widget.troca.troNrId!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              'Troca recusada com sucesso!',
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              e.toString(),
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _cancelarTroca() async {
    bool confirmado = await _mostrarDialogoConfirmacao("CANCELAR");
    if (confirmado) {
      try {
        final trocaController =
            Provider.of<TrocaController>(context, listen: false);
        await trocaController.cancelarTroca(widget.troca.troNrId!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              'Troca cancelada com sucesso!',
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              e.toString(),
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<bool> _mostrarDialogoConfirmacao(String tipoAcao) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirmar Aceite"),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tem certeza de que deseja $tipoAcao esta troca?\n'
                    'Esta ação não pode ser desfeita.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.grey,
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: const Text(
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                    'Cancelar',
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: const Text(
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                    'Aceitar',
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final String status = widget.troca.sttTxStatus!;

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
              '${widget.troca.troNrId}',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Remetente: ${widget.troca.usuTxNomeRemetente}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Telefone: ${widget.troca.conTxNumeroRemetente}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Semente: ${widget.troca.semTxNomeRemetente}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Quantidade: ${widget.troca.troNrQuantidadeSementeRemetente} kg',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            Text(
              'Destinatário: ${widget.troca.usuTxNomeDestinatario}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Telefone: ${widget.troca.conTxNumeroDestinatario}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Semente: ${widget.troca.semTxNomeDestinatario}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Quantidade: ${widget.troca.troNrQuantidadeSementeDestinatario} kg',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            Text(
              'Status: $status',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Data: ${widget.troca.sttDtStatusTroca}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Instruções: ${widget.troca.troTxInstrucoes}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            if (status == 'PENDENTE') ...[
              const Text(
                'Ações Disponíveis:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: _recusarTroca,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      child: const Text(
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                        'Recusar',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: _cancelarTroca,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      child: const Text(
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                        'Cancelar',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: _aceitarTroca,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      child: const Text(
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                        'Aceitar',
                      ),
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
