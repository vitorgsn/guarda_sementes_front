import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/sementes/armazem_controller.dart';
import 'package:guarda_sementes_front/src/controllers/sementes/semente_controller.dart';
import 'package:guarda_sementes_front/src/pages/sementes/form/armazem_form_page.dart';
import 'package:guarda_sementes_front/src/pages/sementes/semente_page.dart';
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
    await armazemController.listarArmazens();
  }

  @override
  Widget build(BuildContext context) {
    final armazemController = Provider.of<ArmazemController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MINHAS SEMENTES'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: armazemController.armazens.isEmpty
            ? FutureBuilder(
                future: armazemController.listarArmazens(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar armazéns: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (armazemController.armazens.isEmpty) {
                    return const Center(
                      child: Text('Nenhum armazém encontrado.'),
                    );
                  }
                  return _buildList(armazemController);
                },
              )
            : _buildList(armazemController),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novoArmazem = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => const ArmazemFormPage(),
            ),
          );

          if (novoArmazem != null) {
            _carregarArmazens();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(ArmazemController controller) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: controller.armazens.length,
      itemBuilder: (BuildContext context, int index) {
        final armazem = controller.armazens[index];
        return GestureDetector(
          onTap: () async {
            final sementeController =
                Provider.of<SementeController>(context, listen: false);
            await sementeController.listarSementes(filtros: {
              'size': 10,
              'page': 0,
              'sort': 'sem_nr_id,desc',
              'armazemId': armazem.armNrId,
            });

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  color: Colors.green[100],
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.grain,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                armazem.armTxDescricao,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
