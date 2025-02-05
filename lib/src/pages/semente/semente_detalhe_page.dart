import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:guarda_sementes_front/src/controllers/semente_controller.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:provider/provider.dart';

class SementeDetalhePage extends StatefulWidget {
  final int semNrId;
  final int armNrId;

  const SementeDetalhePage({
    super.key,
    required this.semNrId,
    required this.armNrId,
  });

  @override
  State<SementeDetalhePage> createState() => _SementeDetalhePageState();
}

class _SementeDetalhePageState extends State<SementeDetalhePage> {
  late TextEditingController _nomeController;
  late TextEditingController _quantidadeController;
  late TextEditingController _descricaoController;

  String _tituloAppBar = "Detalhes da Semente";

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _quantidadeController = TextEditingController();
    _descricaoController = TextEditingController();

    _carregarSemente();
  }

  Future<void> _carregarSemente() async {
    final sementeController =
        Provider.of<SementeController>(context, listen: false);
    final semente = await sementeController.buscarSementePorId(widget.semNrId);

    if (semente != null) {
      _nomeController.text = semente.semTxNome;
      _quantidadeController.text = semente.semNrQuantidade.toString();
      _descricaoController.text = semente.semTxDescricao!;
      _tituloAppBar = semente.semTxNome;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _quantidadeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  double? _converterQuantidade(String quantidade) {
    String quantidadeSemKg = quantidade.replaceAll(" kg", "");
    double? valorConvertido = double.tryParse(quantidadeSemKg);

    if (valorConvertido == null || valorConvertido < 0) {
      return null;
    }

    return valorConvertido;
  }

  void _salvarSemente() async {
    final semente = Semente(
      semNrId: widget.semNrId,
      semTxNome: _nomeController.text,
      semNrQuantidade: _converterQuantidade(_quantidadeController.text)!,
      semTxDescricao: _descricaoController.text,
      armNrId: widget.armNrId,
    );

    await SementeController().atualizarSemente(semente);
    Navigator.pop(context);
  }

  void _excluirSemente() async {
    final bool confirmar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content:
              const Text("Tem certeza de que deseja excluir esta semente?"),
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
        final sementeController =
            Provider.of<SementeController>(context, listen: false);
        await sementeController.excluirSemente(widget.semNrId);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Semente excluída com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao excluir semente: $e")),
        );
      }
    }
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
        title: Text(_tituloAppBar),
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
              child: ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.green[100],
                  child: const Icon(
                    Icons.grain,
                    color: Colors.green,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _quantidadeController,
              decoration: const InputDecoration(labelText: 'Quantidade (kg)'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                CurrencyInputFormatter(
                  thousandSeparator: ThousandSeparator.None,
                  leadingSymbol: '',
                  trailingSymbol: ' kg',
                  mantissaLength: 3,
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Quantidade'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _salvarSemente,
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: _excluirSemente,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Excluir',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
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
