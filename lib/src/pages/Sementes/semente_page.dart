import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:guarda_sementes_front/src/pages/Sementes/form/semente_form_page.dart';
import 'package:guarda_sementes_front/src/pages/Sementes/semente_detalhe_page.dart';
import 'package:guarda_sementes_front/src/services/semente_service.dart';

class SementePage extends StatefulWidget {
  final String categoriaNome;
  final String categoriaIcone;

  const SementePage({
    super.key,
    required this.categoriaNome,
    required this.categoriaIcone,
  });

  @override
  State<SementePage> createState() => _SementePageState();
}

class _SementePageState extends State<SementePage> {
  final SementeService _sementeService = SementeService();
  late Future<List<Semente>> _sementesFuture;

  @override
  void initState() {
    super.initState();
    _sementesFuture = _sementeService.listarSementes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoriaNome),
      ),
      body: FutureBuilder<List<Semente>>(
        future: _sementesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar sementes: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhuma semente encontrada.'),
            );
          }

          final sementes = snapshot.data!;

          return ListView.separated(
            itemCount: sementes.length,
            separatorBuilder: (_, __) => const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            itemBuilder: (context, index) {
              final semente = sementes[index];
              return ListTile(
                leading: ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.green[100],
                    child: const Icon(
                      Icons.grain,
                      color: Colors.green,
                    ), // Imagem fixa
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novaSemente = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => const SementeFormPage(),
            ),
          );

          if (novaSemente != null) {
            setState(() {
              _sementesFuture = _sementeService.listarSementes();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
