import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:guarda_sementes_front/src/controllers/semente_controller.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SementeFormPage extends StatefulWidget {
  final int armNrId;
  const SementeFormPage({
    super.key,
    required this.armNrId,
  });

  @override
  State<SementeFormPage> createState() => _SementeFormPageState();
}

class _SementeFormPageState extends State<SementeFormPage> {
  final _formKey = GlobalKey<FormState>();
  File? _imagem;
  final _nomeController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _descricaoController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imagem = File(pickedFile.path);
      });
    }
  }

  double? _converterQuantidade(String quantidade) {
    String quantidadeSemKg = quantidade.replaceAll(" kg", "");
    double? valorConvertido = double.tryParse(quantidadeSemKg);

    if (valorConvertido == null || valorConvertido < 0) {
      return null;
    }

    return valorConvertido;
  }

  Future<void> _salvarSemente() async {
    if (_formKey.currentState!.validate()) {
      final semente = Semente(
        semTxNome: _nomeController.text,
        semNrQuantidade: _converterQuantidade(_quantidadeController.text)!,
        semTxDescricao: _descricaoController.text,
        armNrId: widget.armNrId,
      );

      try {
        await Provider.of<SementeController>(context, listen: false)
            .criarSemente(semente);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              'Semente salva com sucesso!',
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
          ),
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
  }

  Future<bool> _mostrarInformativo() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Informativo"),
            content: const SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Essa opção ainda não está disponível, por favor, aguarde.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.grey,
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: const Text(
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                    'OK',
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String label) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Semente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  //await _pickImage(ImageSource.gallery);
                  await _mostrarInformativo();
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
              TextFormField(
                controller: _nomeController,
                decoration: inputDecoration('Nome *'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantidadeController,
                decoration: inputDecoration('Quantidade (kg) *'),
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
                controller: _descricaoController,
                decoration: inputDecoration('Descrição'),
              ),
              const SizedBox(height: 16),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: const Text(
                        style: TextStyle(color: Colors.white, fontSize: 15),
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
            ],
          ),
        ),
      ),
    );
  }
}
