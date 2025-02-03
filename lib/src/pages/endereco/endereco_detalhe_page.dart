import 'package:flutter/material.dart';

class EnderecoDetalhePage extends StatefulWidget {
  final int endNrId;
  final String endTxBairro;
  final String endTxLogradouro;
  final String endTxNumero;
  final String endTxReferencia;
  final bool endBlEnderecoPadrao;
  final int? cidNrId;
  final String? cidTxNome;
  final int? estNrId;
  final String? estTxNome;
  final String? estTxSigla;

  const EnderecoDetalhePage({
    super.key,
    required this.endNrId,
    required this.endTxBairro,
    required this.endTxLogradouro,
    required this.endTxNumero,
    required this.endTxReferencia,
    required this.endBlEnderecoPadrao,
    required this.cidNrId,
    required this.cidTxNome,
    required this.estNrId,
    required this.estTxNome,
    required this.estTxSigla,
  });

  @override
  State<EnderecoDetalhePage> createState() => _EnderecoDetalhePageState();
}

class _EnderecoDetalhePageState extends State<EnderecoDetalhePage> {
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
              'Estado: ${widget.estTxNome}/${widget.estTxSigla}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Cidade: ${widget.cidTxNome}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Bairro: ${widget.endTxBairro}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Logradouro: ${widget.endTxLogradouro}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Número: ${widget.endTxNumero}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Referência: ${widget.endTxReferencia}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: widget.endBlEnderecoPadrao,
                  onChanged: (bool? value) {},
                ),
                const Text(
                  'Endereço Padrão',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
