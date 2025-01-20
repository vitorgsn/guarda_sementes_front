import 'package:flutter/material.dart';

class EnderecoDetalhePage extends StatelessWidget {
  final String siglaEstado;
  final String nomeEstado;
  final String cidade;
  final String bairro;
  final String logradouro;
  final String numero;
  final String referencia;

  const EnderecoDetalhePage({
    super.key,
    required this.siglaEstado,
    required this.nomeEstado,
    required this.cidade,
    required this.bairro,
    required this.logradouro,
    required this.numero,
    required this.referencia,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estado: $nomeEstado ($siglaEstado)',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Cidade: $cidade', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Bairro: $bairro', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Logradouro: $logradouro',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Número: $numero', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Referência: $referencia',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
