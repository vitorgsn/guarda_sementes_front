import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/repositories/semente_disponivel_troca_teste_repository.dart';

class SementesDisponiveisTrocaPage extends StatefulWidget {
  const SementesDisponiveisTrocaPage({super.key});

  @override
  State<SementesDisponiveisTrocaPage> createState() =>
      _SementesDisponiveisTrocaPageState();
}

class _SementesDisponiveisTrocaPageState
    extends State<SementesDisponiveisTrocaPage> {
  final tabela = SementeDisponivelTrocaTesteRepository.tabela;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FEIRA DE TROCAS'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int semente) {
          return ListTile(
            leading: SizedBox(
              width: 80,
              child: Image.asset(tabela[semente].icone),
            ),
            title: Text(
              tabela[semente].semTxNome,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              tabela[semente].sdtTxObservacoes,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
              ),
            ),
            trailing: Text(
              '${tabela[semente].sdtNrQuantidade} kg',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        itemCount: tabela.length,
      ),
    );
  }
}
