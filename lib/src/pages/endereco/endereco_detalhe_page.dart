import 'package:flutter/material.dart';

class EnderecoDetalhePage extends StatefulWidget {
  final int endNrId;
  final String endTxBairro;
  final String endTxLogradouro;
  final String endTxNumero;
  final String endTxReferencia;
  final int cidNrId;
  final String endDtCreatedAt;
  final String endDtUpdateAt;
  final bool endBlEnderecoPadrao;

  const EnderecoDetalhePage(
      {super.key,
      required this.endNrId,
      required this.endTxBairro,
      required this.endTxLogradouro,
      required this.endTxNumero,
      required this.endTxReferencia,
      required this.cidNrId,
      required this.endDtCreatedAt,
      required this.endDtUpdateAt,
      required this.endBlEnderecoPadrao});

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
            const Text(
              'Estado: São Paulo (SP)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Cidade: ${widget.cidNrId}',
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
                  onChanged: (bool? value) {
                    // Lógica para atualizar o estado do endereço padrão
                  },
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
