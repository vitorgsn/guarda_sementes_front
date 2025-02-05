import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/armazem_controller.dart';
import 'package:guarda_sementes_front/src/pages/armazem/armazem_form_page.dart';
import 'package:guarda_sementes_front/src/pages/semente/semente_page.dart';
import 'package:provider/provider.dart';

class ArmazemPage extends StatefulWidget {
  const ArmazemPage({super.key});

  @override
  State<ArmazemPage> createState() => _ArmazemPageState();
}

class _ArmazemPageState extends State<ArmazemPage> {
  @override
  void initState() {
    super.initState();
    _carregarArmazens();
  }

  Future<void> _carregarArmazens() async {
    final armazemController =
        Provider.of<ArmazemController>(context, listen: false);
    await armazemController.listarArmazens(filtros: {
      'sort': 'arm_nr_id,desc',
    });
  }

  @override
  Widget build(BuildContext context) {
    final armazemController = Provider.of<ArmazemController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sementes'),
        automaticallyImplyLeading: false,
      ),
      body: armazemController.armazens.isEmpty
          ? const Center(
              child: Text(
                'Nenhum armazém encontrado.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : _buildGrid(armazemController),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => const ArmazemFormPage(),
            ),
          );

          _carregarArmazens();
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text('Novo Armazém'),
      ),
    );
  }

  Widget _buildGrid(ArmazemController controller) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: controller.armazens.length,
      itemBuilder: (BuildContext context, int index) {
        final armazem = controller.armazens[index];
        return GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SementePage(
                  armNrId: armazem.armNrId!,
                  armTxDescricao: armazem.armTxDescricao,
                ),
              ),
            );
          },
          child: Card(
            elevation: 4,
            shadowColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.green[100],
                      child: const Icon(
                        Icons.warehouse,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    armazem.armTxDescricao,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
