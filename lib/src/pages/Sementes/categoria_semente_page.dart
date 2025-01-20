import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/Sementes/semente_page.dart';

class CategoriaSementePage extends StatefulWidget {
  const CategoriaSementePage({super.key});

  @override
  State<CategoriaSementePage> createState() => _CategoriaSementePageState();
}

class _CategoriaSementePageState extends State<CategoriaSementePage> {
  // Simulando categorias do banco. Substitua por dados reais.
  final List<Map<String, String>> categorias = [
    {'nome': 'Frutas', 'icone': 'assets/frutas.png'},
    {'nome': 'Legumes', 'icone': 'assets/legumes.png'},
    {'nome': 'Grãos', 'icone': 'assets/graos.png'},
    {'nome': 'Ervas', 'icone': 'assets/ervas.png'},
    {'nome': 'Flores', 'icone': 'assets/flores.png'},
    {'nome': 'Folhas', 'icone': 'assets/folhas.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MINHAS SEMENTES'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categorias.length,
          itemBuilder: (BuildContext context, int index) {
            final categoria = categorias[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SementePage(
                      categoriaNome: categoria['nome']!,
                      categoriaIcone: categoria['icone']!,
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
                      child: Image.asset(
                        categoria['icone']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    categoria['nome']!,
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
        ),
      ),
    );
  }
}
