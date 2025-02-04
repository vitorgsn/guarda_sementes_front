import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/contato_controller.dart';
import 'package:guarda_sementes_front/src/models/contato.dart';
import 'package:provider/provider.dart';

class ContatoDetalhePage extends StatefulWidget {
  final int conNrId;

  const ContatoDetalhePage({
    super.key,
    required this.conNrId,
  });

  @override
  State<ContatoDetalhePage> createState() => _ContatoDetalhePageState();
}

class _ContatoDetalhePageState extends State<ContatoDetalhePage> {
  late TextEditingController _numeroController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _numeroController = TextEditingController();
    _emailController = TextEditingController();

    _carregarContato();
  }

  Future<void> _carregarContato() async {
    final contatoController =
        Provider.of<ContatoController>(context, listen: false);
    final contato = await contatoController.buscarContatoPorId(widget.conNrId);

    if (contato != null) {
      _numeroController.text = contato.conTxNumero;
      _emailController.text = contato.conTxEmail;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _numeroController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _salvarContato() async {
    final contato = Contato(
      conNrId: widget.conNrId,
      conTxNumero: _numeroController.text,
      conTxEmail: _emailController.text,
    );

    await ContatoController().atualizarContato(contato);
    Navigator.pop(context);
  }

  void _excluirContato() async {
    final bool confirmar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content:
              const Text("Tem certeza de que deseja excluir este contato?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      try {
        final contatoController =
            Provider.of<ContatoController>(context, listen: false);
        await contatoController.excluirContato(widget.conNrId);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contato excluído com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao excluir contato: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _salvarContato,
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: _excluirContato,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Excluir',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
