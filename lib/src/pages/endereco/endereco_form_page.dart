import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guarda_sementes_front/src/controllers/endereco_controller.dart';
import 'package:guarda_sementes_front/src/controllers/cidade_controller.dart';
import 'package:guarda_sementes_front/src/models/endereco.dart';
import 'package:guarda_sementes_front/src/models/cidade.dart';

class EnderecoFormPage extends StatefulWidget {
  const EnderecoFormPage({super.key});

  @override
  State<EnderecoFormPage> createState() => _EnderecoFormPageState();
}

class _EnderecoFormPageState extends State<EnderecoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _referenciaController = TextEditingController();
  bool _enderecoPadrao = false;
  Cidade? _cidadeSelecionada;
  Future<List<Cidade>>? _futureCidades;

  @override
  void initState() {
    super.initState();
    _futureCidades = context.read<CidadeController>().listarCidades();
  }

  @override
  void dispose() {
    _bairroController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _referenciaController.dispose();
    super.dispose();
  }

  Future<void> _salvarEndereco() async {
    if (_formKey.currentState!.validate()) {
      if (_cidadeSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione uma cidade!')),
        );
        return;
      }

      final endereco = Endereco(
        endTxBairro: _bairroController.text,
        endTxLogradouro: _logradouroController.text,
        endTxNumero: _numeroController.text,
        endTxReferencia: _referenciaController.text,
        endBlEnderecoPadrao: _enderecoPadrao,
        cidNrId: _cidadeSelecionada!.cidNrId,
      );

      try {
        await Provider.of<EnderecoController>(context, listen: false)
            .criarEndereco(endereco);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Endereço salvo com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar endereço: $e')),
        );
      }
    }
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
      appBar: AppBar(title: const Text('Cadastrar Endereço')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<Cidade>>(
                future: _futureCidades,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Erro ao carregar cidades'));
                  }
                  final cidades = snapshot.data!;
                  return DropdownButtonFormField<Cidade>(
                    value: _cidadeSelecionada,
                    hint: const Text('Selecione a cidade'),
                    decoration: inputDecoration('Cidade *'),
                    items: cidades.map((cidade) {
                      return DropdownMenuItem(
                        value: cidade,
                        child:
                            Text('${cidade.cidTxNome} - ${cidade.estTxSigla}'),
                      );
                    }).toList(),
                    onChanged: (cidade) {
                      setState(() {
                        _cidadeSelecionada = cidade;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Selecione uma cidade' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bairroController,
                decoration: inputDecoration('Bairro *'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o bairro' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _logradouroController,
                decoration: inputDecoration('Logradouro *'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o logradouro' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numeroController,
                decoration: inputDecoration('Número *'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o número' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _referenciaController,
                decoration: inputDecoration('Referência *'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe a referência' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _enderecoPadrao,
                    onChanged: (bool? value) {
                      setState(() {
                        _enderecoPadrao = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Endereço Padrão',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
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
                    onPressed: _salvarEndereco,
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
