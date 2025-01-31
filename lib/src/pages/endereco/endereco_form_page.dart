import 'package:flutter/material.dart';

class EnderecoFormPage extends StatefulWidget {
  const EnderecoFormPage({super.key});

  @override
  State<EnderecoFormPage> createState() => _EnderecoFormPageState();
}

class _EnderecoFormPageState extends State<EnderecoFormPage> {
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _referenciaController = TextEditingController();
  String? _nomeEstado;
  String? _siglaEstado;
  bool _enderecoPadrao = false;

  Future<List<String>> _buscarCidades(String query) async {
    List<String> cidades = [
      "Lagarto - SE",
      "Paripiranga - BA",
      "Aracaju - SE",
      "Salvador - BA"
    ];
    return cidades
        .where((cidade) => cidade.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _selecionarCidade(String cidade) {
    setState(() {
      _cidadeController.text = cidade;
      List<String> partes = cidade.split(" - ");
      _nomeEstado = partes[1] == "SE" ? "Sergipe" : "Bahia";
      _siglaEstado = partes[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _nomeEstado),
                      decoration: InputDecoration(
                        labelText: 'Nome do Estado',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _siglaEstado),
                      decoration: InputDecoration(
                        labelText: 'Sigla',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return _buscarCidades(textEditingValue.text);
                },
                onSelected: (String selection) {
                  _selecionarCidade(selection);
                },
                fieldViewBuilder: (
                  BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted,
                ) {
                  _cidadeController.text = textEditingController.text;
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: 'Cidade',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _bairroController,
                decoration: InputDecoration(
                  labelText: 'Bairro',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _logradouroController,
                decoration: InputDecoration(
                  labelText: 'Logradouro',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _numeroController,
                decoration: InputDecoration(
                  labelText: 'Número',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _referenciaController,
                decoration: InputDecoration(
                  labelText: 'Referência',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
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
                  const Text('Definir como endereço padrão')
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Lógica para salvar o endereço
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
