import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/contato/contato_form_page.dart';
import 'contato_detalhe_page.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  // Lista simulada de contatos
  final List<Map<String, String>> contatos = [
    {'nome': 'João Silva', 'numero': '1234-5678', 'email': 'joao@email.com'},
    {
      'nome': 'Maria Oliveira',
      'numero': '8765-4321',
      'email': 'maria@email.com'
    },
    {
      'nome': 'Carlos Santos',
      'numero': '5678-1234',
      'email': 'carlos@email.com'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            final contato = contatos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  contato['nome']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Telefone: ${contato['numero']!}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'E-mail: ${contato['email']!}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  // Navegar para a tela de detalhes do contato
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContatoDetalhePage(
                        nome: contato['nome']!,
                        numero: contato['numero']!,
                        email: contato['email']!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a tela de adicionar contato
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContatoFormPage(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
