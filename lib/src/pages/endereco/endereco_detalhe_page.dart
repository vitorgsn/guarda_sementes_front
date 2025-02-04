import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/cidade_controller.dart';
import 'package:guarda_sementes_front/src/controllers/endereco_controller.dart';
import 'package:guarda_sementes_front/src/models/cidade.dart';
import 'package:guarda_sementes_front/src/models/endereco.dart';
import 'package:provider/provider.dart';

class EnderecoDetalhePage extends StatefulWidget {
  final int endNrId;

  const EnderecoDetalhePage({
    super.key,
    required this.endNrId,
  });

  @override
  State<EnderecoDetalhePage> createState() => _EnderecoDetalhePageState();
}

class _EnderecoDetalhePageState extends State<EnderecoDetalhePage> {
  late TextEditingController _bairroController;
  late TextEditingController _logradouroController;
  late TextEditingController _numeroController;
  late TextEditingController _referenciaController;

  late bool _isEnderecoPadrao = false;
  late int _cidadeSelecionadaId = 0;
  List<Cidade> _cidades = [];

  @override
  void initState() {
    super.initState();
    _bairroController = TextEditingController();
    _logradouroController = TextEditingController();
    _numeroController = TextEditingController();
    _referenciaController = TextEditingController();

    _carregarCidades();
    _carregarEndereco();
  }

  Future<void> _carregarEndereco() async {
    final enderecoController =
        Provider.of<EnderecoController>(context, listen: false);
    final endereco =
        await enderecoController.buscarEnderecoPorId(widget.endNrId);

    if (endereco != null) {
      _bairroController.text = endereco.endTxBairro;
      _logradouroController.text = endereco.endTxLogradouro;
      _numeroController.text = endereco.endTxNumero;
      _referenciaController.text = endereco.endTxReferencia;
      _isEnderecoPadrao = endereco.endBlEnderecoPadrao!;
      _cidadeSelecionadaId = endereco.cidNrId!;
    }

    setState(() {});
  }

  Future<void> _carregarCidades() async {
    final cidadeController =
        Provider.of<CidadeController>(context, listen: false);
    _cidades = await cidadeController.listarCidades();
    setState(() {});
  }

  @override
  void dispose() {
    _bairroController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _referenciaController.dispose();
    super.dispose();
  }

  void _salvarEndereco() async {
    final endereco = Endereco(
      endNrId: widget.endNrId,
      endTxBairro: _bairroController.text,
      endTxLogradouro: _logradouroController.text,
      endTxNumero: _numeroController.text,
      endTxReferencia: _referenciaController.text,
      endBlEnderecoPadrao: _isEnderecoPadrao,
      cidNrId: _cidadeSelecionadaId, // Usando a cidade selecionada
    );

    await EnderecoController().atualizarEndereco(endereco);
    Navigator.pop(context);
  }

  void _excluirEndereco() async {
    final bool confirmar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content:
              const Text("Tem certeza de que deseja excluir este endereço?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancela
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirma
              child: const Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      try {
        final enderecoController =
            Provider.of<EnderecoController>(context, listen: false);
        await enderecoController.excluirEndereco(widget.endNrId);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Endereço excluído com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao excluir endereço: $e")),
        );
      }
    }
  }

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
            DropdownButtonFormField<int>(
              value: _cidadeSelecionadaId,
              decoration: const InputDecoration(labelText: 'Cidade'),
              items: _cidades.map((cidade) {
                return DropdownMenuItem<int>(
                  value: cidade.cidNrId,
                  child: Text('${cidade.cidTxNome}/${cidade.estTxSigla}'),
                );
              }).toList(),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    _cidadeSelecionadaId = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bairroController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _logradouroController,
              decoration: const InputDecoration(labelText: 'Logradouro'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(labelText: 'Número'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _referenciaController,
              decoration: const InputDecoration(labelText: 'Referência'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isEnderecoPadrao,
                  onChanged: (bool? value) {
                    setState(() {
                      _isEnderecoPadrao = value ?? false;
                    });
                  },
                ),
                const Text(
                  'Endereço Padrão',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _salvarEndereco,
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: _excluirEndereco,
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
