import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/sementes/semente_controller.dart';
import 'package:guarda_sementes_front/src/pages/sementes/form/semente_form_page.dart';
import 'package:guarda_sementes_front/src/pages/sementes/semente_detalhe_page.dart';
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
    await sementeController
        .listarSementes(filtros: {'armNrId': widget.armNrId});
  }

  @override
  Widget build(BuildContext context) {
    final sementeController = Provider.of<SementeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.armTxDescricao),
      ),
      body: sementeController.sementes.isEmpty
          ? const Center(child: Text('Nenhuma semente encontrada.'))
          : _buildList(sementeController),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novaSemente = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => const SementeFormPage(),
            ),
          );

          if (novaSemente != null) {
            _carregarSementes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(SementeController controller) {
    return ListView.separated(
      itemCount: controller.sementes.length,
      separatorBuilder: (_, __) => const Divider(
        thickness: 1,
        color: Colors.grey,
      ),
      itemBuilder: (context, index) {
        final semente = controller.sementes[index];
        return ListTile(
          leading: ClipOval(
            child: Container(
              width: 50,
              height: 50,
              color: Colors.green[100],
              child: const Icon(
                Icons.grain,
                color: Colors.green,
              ),
            ),
          ),
          title: Text(
            semente.semTxNome,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            semente.semTxDescricao,
            style: const TextStyle(fontSize: 14),
          ),
          trailing: Text(
            '${semente.semNrQuantidade} kg',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        );
      },
    );
  }
}
