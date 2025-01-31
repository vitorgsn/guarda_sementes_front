import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/semente_controller.dart';
import 'package:guarda_sementes_front/src/pages/semente/semente_form_page.dart';
import 'package:guarda_sementes_front/src/pages/semente/semente_detalhe_page.dart';
import 'package:provider/provider.dart';

class SementePage extends StatefulWidget {
  final int armNrId;
  final String armTxDescricao;

  const SementePage({
    super.key,
    required this.armNrId,
    required this.armTxDescricao,
  });

  @override
  State<SementePage> createState() => _SementePageState();
}

class _SementePageState extends State<SementePage> {
  @override
  void initState() {
    super.initState();
    _carregarSementes();
  }

  Future<void> _carregarSementes() async {
    final sementeController =
        Provider.of<SementeController>(context, listen: false);
    await sementeController.listarSementes(filtros: {
      'sort': 'sem_nr_id,desc',
      'armNrId': widget.armNrId,
    });
  }

  @override
  Widget build(BuildContext context) {
    final sementeController = Provider.of<SementeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.armTxDescricao),
        backgroundColor: Colors.green,
      ),
      body: sementeController.sementes.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma semente encontrada.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : _buildGrid(sementeController),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => SementeFormPage(
                armNrId: widget.armNrId,
              ),
            ),
          );

          _carregarSementes();
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text('Nova Semente'),
      ),
    );
  }

  Widget _buildGrid(SementeController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 2,
        ),
        itemCount: controller.sementes.length,
        itemBuilder: (context, index) {
          final semente = controller.sementes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SementeDetalhePage(
                    imagem: 'assets/semente1.png', // Imagem fixa
                    nome: semente.semTxNome,
                    quantidade: semente.semNrQuantidade,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.green[100],
                        child: const Icon(
                          Icons.grain,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      semente.semTxNome,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${semente.semNrQuantidade} kg',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
