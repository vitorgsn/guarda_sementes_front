import 'package:flutter/material.dart';

class EscolherSementeTrocaPage extends StatefulWidget {
  final dynamic sementeSelecionada;

  const EscolherSementeTrocaPage({super.key, required this.sementeSelecionada});

  @override
  State<EscolherSementeTrocaPage> createState() =>
      _EscolherSementeTrocaPageState();
}

class _EscolherSementeTrocaPageState extends State<EscolherSementeTrocaPage> {
  final List<dynamic> sementesDoUsuario = [
    {
      'nome': 'Milho',
      'quantidade': 5,
      'imagemUrl': 'https://via.placeholder.com/150?text=Milho',
    },
    {
      'nome': 'Feijão',
      'quantidade': 3,
      'imagemUrl': 'https://via.placeholder.com/150?text=Feijão',
    },
    {
      'nome': 'Trigo',
      'quantidade': 7,
      'imagemUrl': 'https://via.placeholder.com/150?text=Trigo',
    },
  ];

  void abrirJanelaTroca(
      BuildContext context, Map<String, dynamic> sementeUsuario) {
    int quantidadeSelecionada = 1; // Quantidade inicial selecionada
    final TextEditingController instrucoesController =
        TextEditingController(); // Controlador para as instruções

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Permite rolar se necessário
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Trocar ${sementeUsuario['nome']} pela ${widget.sementeSelecionada.semTxNome}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Selecione a quantidade para a troca:',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: quantidadeSelecionada > 1
                        ? () {
                            setState(() {
                              quantidadeSelecionada--;
                            });
                          }
                        : null,
                  ),
                  Text(
                    '$quantidadeSelecionada',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed:
                        quantidadeSelecionada < sementeUsuario['quantidade']
                            ? () {
                                setState(() {
                                  quantidadeSelecionada++;
                                });
                              }
                            : null,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: instrucoesController,
                decoration: const InputDecoration(
                  labelText: 'Instruções de troca',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3, // Permite até 3 linhas de texto
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Confirmar a troca com a quantidade selecionada e as instruções
                  print(
                      'Confirmado: Trocar $quantidadeSelecionada de ${sementeUsuario['nome']} pela ${widget.sementeSelecionada.semTxNome}');
                  print(
                      'Instruções fornecidas: ${instrucoesController.text.trim()}');
                  Navigator.pop(context); // Fechar a janela
                },
                child: const Text('Propor Troca'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trocar por ${widget.sementeSelecionada.semTxNome}'),
      ),
      body: ListView.builder(
        itemCount: sementesDoUsuario.length,
        itemBuilder: (context, index) {
          final sementeUsuario = sementesDoUsuario[index];
          return ListTile(
            leading: Image.network(
              sementeUsuario['imagemUrl'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(sementeUsuario['nome']),
            subtitle: Text('Quantidade: ${sementeUsuario['quantidade']}'),
            trailing: ElevatedButton(
              onPressed: () => abrirJanelaTroca(context, sementeUsuario),
              child: const Text('Trocar'),
            ),
          );
        },
      ),
    );
  }
}
