import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/endereco/endereco_detalhe_page.dart';
import 'package:guarda_sementes_front/src/pages/endereco/endereco_form_page.dart';

class EnderecoPage extends StatefulWidget {
  const EnderecoPage({super.key});

  @override
  State<EnderecoPage> createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  // Lista simulada de endereços, com base no DTO fornecido
  final List<Map<String, dynamic>> enderecos = [
    {
      'endNrId': 6,
      'endTxBairro': 'Matadouro',
      'endTxLogradouro': 'Rua do Matadouro',
      'endTxNumero': '25',
      'endTxReferencia': 'Próx. ao Matadouro',
      'cidNrId': 2,
      'endDtCreatedAt': '2025-01-30T21:53:30.102961',
      'endDtUpdateAt': '2025-01-30T21:53:30.102979',
      'endBlEnderecoPadrao': true,
    },
    {
      'endNrId': 5,
      'endTxBairro': 'Centro',
      'endTxLogradouro': 'Rua 2',
      'endTxNumero': '2',
      'endTxReferencia': 'Próx. a Praça',
      'cidNrId': 1,
      'endDtCreatedAt': '2025-01-30T21:47:39.053063',
      'endDtUpdateAt': '2025-01-30T21:51:25.772012',
      'endBlEnderecoPadrao': false,
    },
    {
      'endNrId': 4,
      'endTxBairro': 'Loiola',
      'endTxLogradouro': 'Rua 10',
      'endTxNumero': '20',
      'endTxReferencia': 'Próx. ao Estádio',
      'cidNrId': 1,
      'endDtCreatedAt': '2025-01-30T21:46:37.321691',
      'endDtUpdateAt': '2025-01-30T21:53:30.104696',
      'endBlEnderecoPadrao': false,
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
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${endereco['endTxLogradouro']}, ${endereco['endTxNumero']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (endereco['endBlEnderecoPadrao'] == true)
                      const Icon(Icons.star, color: Colors.amber),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      '${endereco['endTxBairro']} - Cidade ID: ${endereco['cidNrId']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Referência: ${endereco['endTxReferencia']}',
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
                        endNrId: endereco['endNrId']!,
                        endTxBairro: endereco['endTxBairro']!,
                        endTxLogradouro: endereco['endTxLogradouro']!,
                        endTxNumero: endereco['endTxNumero']!,
                        endTxReferencia: endereco['endTxReferencia']!,
                        cidNrId: endereco['cidNrId']!,
                        endDtCreatedAt: endereco['endDtCreatedAt']!,
                        endDtUpdateAt: endereco['endDtUpdateAt']!,
                        endBlEnderecoPadrao: endereco['endBlEnderecoPadrao']!,
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
