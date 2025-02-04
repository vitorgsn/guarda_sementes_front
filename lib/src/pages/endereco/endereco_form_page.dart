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
                    decoration: const InputDecoration(labelText: 'Cidade'),
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
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o bairro' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _logradouroController,
                decoration: const InputDecoration(labelText: 'Logradouro'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o logradouro' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(labelText: 'Número'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o número' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _referenciaController,
                decoration: const InputDecoration(labelText: 'Referência'),
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
                  const Text('Endereço Padrão'),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _salvarEndereco,
                    child: const Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
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
