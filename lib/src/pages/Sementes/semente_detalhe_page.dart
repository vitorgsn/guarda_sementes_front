import 'package:flutter/material.dart';

class SementeDetalhePage extends StatefulWidget {
  final String imagem;
  final String nome;
  final double quantidade;

  const SementeDetalhePage({
    super.key,
    required this.imagem,
    required this.nome,
    required this.quantidade,
  });

  @override
  State<SementeDetalhePage> createState() => _SementeDetalhePageState();
}

class _SementeDetalhePageState extends State<SementeDetalhePage> {
  late TextEditingController quantidadeController;
  bool isSalvarEnabled = false;

  @override
  void initState() {
    super.initState();
    quantidadeController =
        TextEditingController(text: widget.quantidade.toString());

    quantidadeController.addListener(() {
      final int? novaQuantidade = int.tryParse(quantidadeController.text);
      if (novaQuantidade != null && novaQuantidade != widget.quantidade) {
        setState(() {
          isSalvarEnabled = true;
        });
      } else {
        setState(() {
          isSalvarEnabled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    quantidadeController.dispose();
    super.dispose();
  }

  void salvarQuantidade() {
    final novaQuantidade = int.parse(quantidadeController.text);
    print('Nova quantidade salva: $novaQuantidade');
    setState(() {
      isSalvarEnabled = false;
    });
  }

  void excluirSemente() {
    print('Semente excluída!');
    Navigator.pop(context);
  }

  void disponibilizarParaTroca() {
    final quantidadeTrocaController = TextEditingController();
    final observacaoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Disponibilizar para troca'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: quantidadeTrocaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: observacaoController,
                decoration: const InputDecoration(
                  labelText: 'Observação',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final quantidade = quantidadeTrocaController.text;
                final observacao = observacaoController.text;

                // Aqui você pode salvar os dados em uma API ou banco de dados
                print('Disponibilizado para troca:');
                print('Quantidade: $quantidade');
                print('Observação: $observacao');

                Navigator.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.imagem,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.nome,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Quantidade:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: quantidadeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isSalvarEnabled ? salvarQuantidade : null,
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: excluirSemente,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text('Excluir'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: disponibilizarParaTroca,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Disponibilizar para troca',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
