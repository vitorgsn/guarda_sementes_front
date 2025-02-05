import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/armazem_controller.dart';
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

  Future<void> _excluirArmazem() async {
    bool confirmado = await _mostrarDialogoConfirmacao();
    if (confirmado) {
      try {
        final armazemController =
            Provider.of<ArmazemController>(context, listen: false);
        await armazemController.excluirArmazem(widget.armNrId);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Armazém excluído com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao excluir Armazém: $e")),
        );
      }
    }
  }

  Future<bool> _mostrarDialogoConfirmacao() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirmar Exclusão"),
            content: const Text(
                "Tem certeza de que deseja excluir este armazém? Esta ação não pode ser desfeita."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Excluir",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final sementeController = Provider.of<SementeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.armTxDescricao),
      ),
      body: sementeController.sementes.isEmpty
          ? _buildSemSementes()
          : _buildGrid(sementeController),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SementeFormPage(
                armNrId: widget.armNrId,
              ),
            ),
          ).then((_) {
            _carregarSementes();
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSemSementes() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Nenhuma semente encontrada.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _excluirArmazem,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              "Excluir Armazém",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
                    semNrId: semente.semNrId!,
                    armNrId: widget.armNrId,
                  ),
                ),
              ).then((_) {
                _carregarSementes();
              });
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
