import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:guarda_sementes_front/src/controllers/semente_controller.dart';
import 'package:guarda_sementes_front/src/controllers/semente_disponivel_troca_controller.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:guarda_sementes_front/src/models/semente_disponivel_troca.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _imagem;
  late TextEditingController _quantidadeParaTrocaController;
  late TextEditingController _observacoesParaTrocaController;

  String _tituloAppBar = "Detalhes da Semente";

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _quantidadeController = TextEditingController();
    _descricaoController = TextEditingController();
    _quantidadeParaTrocaController = TextEditingController();
    _observacoesParaTrocaController = TextEditingController();

    _carregarSemente();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imagem = File(pickedFile.path);
      });
    }
  }

  Future<void> _carregarSemente() async {
    final sementeController =
        Provider.of<SementeController>(context, listen: false);
    final semente = await sementeController.buscarSementePorId(widget.semNrId);

    if (semente != null) {
      setState(() {
        _nomeController.text = semente.semTxNome;
        _quantidadeController.text = semente.semNrQuantidade.toString();
        _descricaoController.text = semente.semTxDescricao ?? '';
        _tituloAppBar = semente.semTxNome;
      });
    }
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
    final sementeController =
        Provider.of<SementeController>(context, listen: false);

    final semente = Semente(
      semNrId: widget.semNrId,
      semTxNome: _nomeController.text,
      semNrQuantidade: _converterQuantidade(_quantidadeController.text)!,
      semTxDescricao: _descricaoController.text,
      armNrId: widget.armNrId,
    );

    await sementeController.atualizarSemente(semente);
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

  InputDecoration _inputDecoration(String label) {
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

  Future<void> _disponibilizarParaTroca() async {
    final sementeDisponivelTrocaController =
        Provider.of<SementeDisponivelTrocaController>(context, listen: false);

    SementeDisponivelTroca semente = SementeDisponivelTroca(
      semNrIdSemente: widget.semNrId,
      sdtNrQuantidade:
          _converterQuantidade(_quantidadeParaTrocaController.text)!,
      sdtTxObservacoes: _observacoesParaTrocaController.text,
    );

    try {
      await sementeDisponivelTrocaController
          .cadastrarSementeDisponivelTroca(semente);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Semente disponibilizada para troca com sucesso!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            e.toString(),
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _mostrarDialogoTroca() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Disponibilizar para troca"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _quantidadeParaTrocaController,
                decoration: _inputDecoration('Quantidade (kg) *'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    thousandSeparator: ThousandSeparator.None,
                    leadingSymbol: '',
                    trailingSymbol: ' kg',
                    mantissaLength: 3,
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade';
                  }
                  String quantidadeSemKg = value.replaceAll(' kg', '').trim();
                  double? quantidade = double.tryParse(quantidadeSemKg);

                  if (quantidade == null || quantidade <= 0) {
                    return 'Insira um número válido e maior que zero';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _observacoesParaTrocaController,
                decoration: _inputDecoration('Observações *'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe as observações de troca' : null,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: const Text(
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                      'Cancelar',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: _disponibilizarParaTroca,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: const Text(
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                      'Confirmar',
                    ),
                  ),
                ),
              ],
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
            GestureDetector(
              onTap: () async {
                await _pickImage(ImageSource.gallery);
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[50],
                ),
                child: _imagem == null
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_camera,
                              size: 50,
                              color: Colors.grey,
                            ),
                            Text(
                              'Clique para adicionar uma imagem',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _imagem!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nomeController,
              decoration: _inputDecoration('Nome *'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _quantidadeController,
              decoration: _inputDecoration('Quantidade (kg)*'),
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
              decoration: _inputDecoration('Descrição'),
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
                  onPressed: _excluirSemente,
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
                  onPressed: _salvarSemente,
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
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: _mostrarDialogoTroca,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: const Text(
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                  'Disponibilizar para troca',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
