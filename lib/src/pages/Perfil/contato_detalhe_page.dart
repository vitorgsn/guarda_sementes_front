import 'package:flutter/material.dart';

class ContatoDetalhePage extends StatefulWidget {
  final String nome;
  final String numero;
  final String email;

  const ContatoDetalhePage({
    super.key,
    required this.nome,
    required this.numero,
    required this.email,
  });

  @override
  State<ContatoDetalhePage> createState() => _ContatoDetalhePageState();
}

class _ContatoDetalhePageState extends State<ContatoDetalhePage> {
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
            Text(
              'Nome: ${widget.nome}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Número: ${widget.numero}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Email: ${widget.email}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
