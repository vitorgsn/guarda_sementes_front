import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:guarda_sementes_front/src/controllers/contato_controller.dart';
import 'package:guarda_sementes_front/src/models/contato.dart';
import 'package:provider/provider.dart';

class ContatoFormPage extends StatefulWidget {
  const ContatoFormPage({super.key});

  @override
  State<ContatoFormPage> createState() => _ContatoFormPageState();
}

class _ContatoFormPageState extends State<ContatoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _numeroController = MaskedTextController(mask: '(00) 0 0000-0000');
  final _emailController = TextEditingController();
  bool _contatoPadrao = false;

  @override
  void dispose() {
    _numeroController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _salvarContato() async {
    if (_formKey.currentState!.validate()) {
      final contato = Contato(
        conTxNumero: _numeroController.text,
        conTxEmail: _emailController.text,
        conBlContatoPadrao: _contatoPadrao,
      );

      try {
        await Provider.of<ContatoController>(context, listen: false)
            .criarContato(contato);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contato salvo com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar contato: $e')),
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
      appBar: AppBar(
        title: const Text('Cadastrar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _numeroController,
                keyboardType: TextInputType.phone,
                decoration: inputDecoration('Telefone *'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O telefone é obrigatório';
                  }
                  final phoneRegex = RegExp(r'^\(\d{2}\) \d{1} \d{4}-\d{4}$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Formato de telefone inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: inputDecoration('E-mail *'),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O e-mail é obrigatório';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _contatoPadrao,
                    onChanged: (bool? value) {
                      setState(() {
                        _contatoPadrao = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Contato Padrão',
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
                    onPressed: _salvarContato,
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
