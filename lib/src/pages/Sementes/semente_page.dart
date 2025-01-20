import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/Sementes/form/semente_form_page.dart';
import 'package:guarda_sementes_front/src/pages/Sementes/semente_detalhe_page.dart';

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
  final List<Map<String, dynamic>> sementes = [
    {'imagem': 'assets/semente1.png', 'nome': 'Semente A', 'quantidade': 5},
    {'imagem': 'assets/semente2.png', 'nome': 'Semente B', 'quantidade': 10},
    {'imagem': 'assets/semente3.png', 'nome': 'Semente C', 'quantidade': 2},
  ];

  void adicionarSemente(Map<String, dynamic> novaSemente) {
    setState(() {
      sementes.add(novaSemente);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoriaNome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
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
                        child: Image.asset(
                          semente['imagem'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      semente['nome'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${semente['quantidade']} kg',
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
                            imagem: semente['imagem'],
                            nome: semente['nome'],
                            quantidade: semente['quantidade'],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
            adicionarSemente(novaSemente);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
