import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/armazem_controller.dart';
import 'package:guarda_sementes_front/src/controllers/categoria_armazem_controller.dart';
import 'package:guarda_sementes_front/src/models/armazem.dart';
import 'package:guarda_sementes_front/src/models/categoria_armazem.dart';
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
  final _descricaoController = TextEditingController();

  CategoriaArmazem? _categoriaSelecionada;
  Future<List<CategoriaArmazem>>? _futureCategorias;

  @override
  void initState() {
    super.initState();
    _futureCategorias =
        context.read<CategoriaArmazemController>().listarCategoriasArmazem();
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    super.dispose();
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

  Future<void> _salvarArmazem() async {
    if (_formKey.currentState!.validate()) {
      if (_categoriaSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione uma categoria!')),
        );
        return;
      }

      final armazem = Armazem(
        armTxDescricao: _descricaoController.text,
        ctaNrId: _categoriaSelecionada!.ctaNrId,
      );

      try {
        await Provider.of<ArmazemController>(context, listen: false)
            .criarArmazem(armazem);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Armazém salvo com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar armazém: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Armazém')),
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
              FutureBuilder<List<CategoriaArmazem>>(
                future: _futureCategorias,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Erro ao carregar categorias'));
                  }
                  final categorias = snapshot.data!;
                  return DropdownButtonFormField<CategoriaArmazem>(
                    value: _categoriaSelecionada,
                    hint: const Text('Selecione a categoria'),
                    decoration: _inputDecoration('Categoria *'),
                    items: categorias.map((categoria) {
                      return DropdownMenuItem(
                        value: categoria,
                        child: Text(categoria.ctaTxNome),
                      );
                    }).toList(),
                    onChanged: (categoria) {
                      setState(() {
                        _categoriaSelecionada = categoria;
                        _descricaoController.text = categoria?.ctaTxNome ?? '';
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Selecione uma categoria' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: _inputDecoration('Descrição'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe a descrição' : null,
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
                    onPressed: _salvarArmazem,
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
