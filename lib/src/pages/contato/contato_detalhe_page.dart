import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
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
  late MaskedTextController _numeroController;
  late TextEditingController _emailController;
  late bool _isContatoPadrao = false;

  @override
  void initState() {
    super.initState();
    _numeroController = MaskedTextController(mask: '(00) 0 0000-0000');
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
      _isContatoPadrao = contato.conBlContatoPadrao ?? false;
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
      conBlContatoPadrao: _isContatoPadrao,
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
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String label) {
      return InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
      );
    }

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
            TextFormField(
              controller: _numeroController,
              keyboardType: TextInputType.phone,
              decoration: inputDecoration('Telefone *'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'O telefone é obrigatório';
                }
                return value;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: inputDecoration('E-mail *'),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'O e-mail é obrigatório';
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(value)) {
                  return 'E-mail inválido';
                }
                return null;
              },
            ),
            Row(
              children: [
                Checkbox(
                  value: _isContatoPadrao,
                  onChanged: (bool? value) {
                    setState(() {
                      _isContatoPadrao = value ?? false;
                    });
                  },
                ),
                const Text(
                  'Contato Padrão',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: _excluirContato,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: const Text(
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                      'Excluir',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: _salvarContato,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: const Text(
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                      'Salvar',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
