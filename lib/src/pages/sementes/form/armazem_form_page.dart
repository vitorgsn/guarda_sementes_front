import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/sementes/armazem_controller.dart';
import 'package:guarda_sementes_front/src/models/sementes/armazem.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ArmazemFormPage extends StatefulWidget {
  const ArmazemFormPage({
    super.key,
  });

  @override
  State<ArmazemFormPage> createState() => _ArmazemFormPageState();
}

class _ArmazemFormPageState extends State<ArmazemFormPage> {
  final _formKey = GlobalKey<FormState>();
  File? _imagem;
  final _categoriaController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Armazén'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () async {
                  await _pickImage(ImageSource.gallery);
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _imagem == null
                      ? const Center(
                          child: Text(
                            'Clique para adicionar uma imagem',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
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
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoria'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  if (int.tryParse(value) == null || int.tryParse(value)! < 0) {
                    return 'Insira um número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          context
                              .read<ArmazemController>()
                              .criarArmazem(Armazem(
                                armTxDescricao: _descricaoController.text,
                                ctaNrId: int.parse(_categoriaController.text),
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.greenAccent,
                              content: Text(
                                'Armazén criado com sucesso!',
                                textAlign: TextAlign.center,
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Erro ao criar Armázem: $e')),
                          );
                        }
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
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
