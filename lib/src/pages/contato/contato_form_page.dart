import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/contato_controller.dart';
import 'package:guarda_sementes_front/src/models/contato.dart';
import 'package:provider/provider.dart';

class ContatoFormPage extends StatefulWidget {
  const ContatoFormPage({super.key});

  @override
  State<ContatoFormPage> createState() => _ContatoFormPageState();
}

class _ContatoFormPageState extends State<ContatoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _numeroController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _numeroController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _salvarContato() async {
    print(_formKey.currentState);

    if (_formKey.currentState!.validate()) {
      final contato = Contato(
        conTxNumero: _numeroController.text,
        conTxEmail: _emailController.text,
      );

      try {
        await Provider.of<ContatoController>(context, listen: false)
            .criarContato(contato);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contato salvo com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar contato: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: _numeroController,
                decoration: const InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _salvarContato,
                    child: const Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
