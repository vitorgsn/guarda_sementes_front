import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/endereco/endereco_detalhe_page.dart';
import 'package:guarda_sementes_front/src/pages/endereco/endereco_form_page.dart';

class EnderecoPage extends StatefulWidget {
  const EnderecoPage({super.key});

  @override
  State<EnderecoPage> createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  // Lista simulada de endereços
  final List<Map<String, String>> enderecos = [
    {
      'siglaEstado': 'SP',
      'nomeEstado': 'São Paulo',
      'cidade': 'São Paulo',
      'bairro': 'Centro',
      'logradouro': 'Rua A',
      'numero': '123',
      'referencia': 'Próximo ao mercado'
    },
    {
      'siglaEstado': 'RJ',
      'nomeEstado': 'Rio de Janeiro',
      'cidade': 'Rio de Janeiro',
      'bairro': 'Copacabana',
      'logradouro': 'Avenida Atlântica',
      'numero': '456',
      'referencia': 'Frente à praia'
    },
    {
      'siglaEstado': 'MG',
      'nomeEstado': 'Minas Gerais',
      'cidade': 'Belo Horizonte',
      'bairro': 'Savassi',
      'logradouro': 'Rua B',
      'numero': '789',
      'referencia': 'Perto da praça'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Endereços'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: enderecos.length,
          itemBuilder: (context, index) {
            final endereco = enderecos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  '${endereco['logradouro']}, ${endereco['numero']}',
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
                      '${endereco['bairro']} - ${endereco['cidade']} (${endereco['siglaEstado']})',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Referência: ${endereco['referencia']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  // Navegar para a tela de detalhes do endereço
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnderecoDetalhePage(
                        siglaEstado: endereco['siglaEstado']!,
                        nomeEstado: endereco['nomeEstado']!,
                        cidade: endereco['cidade']!,
                        bairro: endereco['bairro']!,
                        logradouro: endereco['logradouro']!,
                        numero: endereco['numero']!,
                        referencia: endereco['referencia']!,
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
          // Navegar para a tela de adicionar endereço
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EnderecoFormPage(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
