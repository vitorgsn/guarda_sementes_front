import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/perfil/endereco_detalhe_page.dart';
import 'package:guarda_sementes_front/src/pages/sementes/form/endereco_form_page.dart';

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
      ),
      body: ListView.builder(
        itemCount: enderecos.length,
        itemBuilder: (context, index) {
          final endereco = enderecos[index];
          return ListTile(
            title: Text(
              '${endereco['logradouro']}, ${endereco['numero']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                '${endereco['bairro']} - ${endereco['cidade']} (${endereco['siglaEstado']})'),
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
          );
        },
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
