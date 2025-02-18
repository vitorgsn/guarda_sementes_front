import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/endereco_controller.dart';
import 'package:guarda_sementes_front/src/pages/endereco/endereco_detalhe_page.dart';
import 'package:guarda_sementes_front/src/pages/endereco/endereco_form_page.dart';
import 'package:provider/provider.dart';

class EnderecoPage extends StatefulWidget {
  const EnderecoPage({super.key});

  @override
  State<EnderecoPage> createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  @override
  void initState() {
    super.initState();
    _carregarEnderecos();
  }

  Future<void> _carregarEnderecos() async {
    final enderecoController =
        Provider.of<EnderecoController>(context, listen: false);
    await enderecoController.listarEnderecos(filtros: {
      'sort': 'end_bl_endereco_padrao,desc',
    });
  }

  @override
  Widget build(BuildContext context) {
    final enderecoController = Provider.of<EnderecoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Endereços'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListView.builder(
          itemCount: enderecoController.enderecos.length,
          itemBuilder: (context, index) {
            final endereco = enderecoController.enderecos[index];
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
                        '${endereco.endTxLogradouro}, ${endereco.endTxNumero}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (endereco.endBlEnderecoPadrao == true)
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
                      '${endereco.endTxBairro} - ${endereco.cidTxNome}/${endereco.estTxSigla}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Referência: ${endereco.endTxReferencia}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnderecoDetalhePage(
                        endNrId: endereco.endNrId!,
                      ),
                    ),
                  ).then((_) {
                    _carregarEnderecos();
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
              builder: (context) => const EnderecoFormPage(),
            ),
          ).then((_) {
            _carregarEnderecos();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
