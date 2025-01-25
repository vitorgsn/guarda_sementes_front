import 'package:flutter/material.dart';

class EnderecoFormPage extends StatefulWidget {
  const EnderecoFormPage({super.key});

  @override
  State<EnderecoFormPage> createState() => _EnderecoFormPageState();
}

class _EnderecoFormPageState extends State<EnderecoFormPage> {
  final _siglaEstadoController = TextEditingController();
  final _nomeEstadoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _bairroController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _referenciaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _siglaEstadoController,
              decoration: const InputDecoration(labelText: 'Sigla do Estado'),
            ),
            TextField(
              controller: _nomeEstadoController,
              decoration: const InputDecoration(labelText: 'Nome do Estado'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _bairroController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),
            TextField(
              controller: _logradouroController,
              decoration: const InputDecoration(labelText: 'Logradouro'),
            ),
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(labelText: 'Número'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _referenciaController,
              decoration: const InputDecoration(labelText: 'Referência'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar o endereço
              },
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
