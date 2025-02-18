import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/contato_controller.dart';
import 'package:guarda_sementes_front/src/pages/contato/contato_form_page.dart';
import 'package:provider/provider.dart';
import 'contato_detalhe_page.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    final contatoController =
        Provider.of<ContatoController>(context, listen: false);
    await contatoController.listarContatos(filtros: {
      'sort': 'con_bl_contato_padrao,desc',
    });
  }

  @override
  Widget build(BuildContext context) {
    final contatoController = Provider.of<ContatoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListView.builder(
          itemCount: contatoController.contatos.length,
          itemBuilder: (context, index) {
            final contato = contatoController.contatos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Telefone: ${contato.conTxNumero}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (contato.conBlContatoPadrao == true)
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'E-mail: ${contato.conTxEmail}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContatoDetalhePage(
                        conNrId: contato.conNrId!,
                      ),
                    ),
                  ).then((_) {
                    _carregarContatos();
                  });
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContatoFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
