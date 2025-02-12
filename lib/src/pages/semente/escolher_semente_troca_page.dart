import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:guarda_sementes_front/src/controllers/semente_controller.dart';
import 'package:guarda_sementes_front/src/controllers/troca_controller.dart';
import 'package:guarda_sementes_front/src/models/semente.dart';
import 'package:guarda_sementes_front/src/models/semente_disponivel_troca.dart';
import 'package:guarda_sementes_front/src/models/troca.dart';
import 'package:provider/provider.dart';

class EscolherSementeTrocaPage extends StatefulWidget {
  final dynamic sementeSelecionada;

  const EscolherSementeTrocaPage({super.key, required this.sementeSelecionada});

  @override
  State<EscolherSementeTrocaPage> createState() =>
      _EscolherSementeTrocaPageState();
}

class _EscolherSementeTrocaPageState extends State<EscolherSementeTrocaPage> {
  late TextEditingController _quantidadeParaTrocaController;
  late TextEditingController _instrucoesParaTrocaController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _quantidadeParaTrocaController = TextEditingController();
      _instrucoesParaTrocaController = TextEditingController();

      _carregarSementes();
    });
  }

  Future<void> _carregarSementes() async {
    final sementeController =
        Provider.of<SementeController>(context, listen: false);
    await sementeController.listarSementes(filtros: {
      'sort': 'sem_nr_id,desc',
    });
  }

  void atualizarBusca(String valor) {
    final sementeController =
        Provider.of<SementeController>(context, listen: false);

    sementeController.listarSementes(
      filtros: {
        'semTxNome': valor,
        'semTxDescricao': valor,
      },
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.green),
      ),
    );
  }

  double? _converterQuantidade(String quantidade) {
    String quantidadeSemKg = quantidade.replaceAll(" kg", "");
    double? valorConvertido = double.tryParse(quantidadeSemKg);

    if (valorConvertido == null || valorConvertido < 0) {
      return null;
    }

    return valorConvertido;
  }

  Future<void> _proporTroca(SementeDisponivelTroca sementeDestinatarioTroca,
      Semente sementeRemetenteTroca) async {
    final trocaController =
        Provider.of<TrocaController>(context, listen: false);

    Troca troca = Troca(
      troTxInstrucoes: _instrucoesParaTrocaController.text,
      usuNrIdDestinatario: sementeDestinatarioTroca.usuNrId!,
      semNrIdSementeDestinatario: sementeDestinatarioTroca.semNrIdSemente,
      troNrQuantidadeSementeDestinatario:
          sementeDestinatarioTroca.sdtNrQuantidade,
      semNrIdSementeRemetente: sementeRemetenteTroca.semNrId!,
      troNrQuantidadeSementeRemetente:
          _converterQuantidade(_quantidadeParaTrocaController.text)!,
    );

    await trocaController.criarTroca(troca);
    Navigator.pop(context);
  }

  void _mostrarDialogoTroca(SementeDisponivelTroca sementeDestinatarioTroca,
      Semente sementeRemetenteTroca) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text.rich(
            TextSpan(
              text: 'Trocar ',
              children: [
                TextSpan(
                  text: sementeRemetenteTroca.semTxNome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: ' por ',
                ),
                TextSpan(
                  text: sementeDestinatarioTroca.semTxNome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _quantidadeParaTrocaController,
                decoration: _inputDecoration('Quantidade (kg) *'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    thousandSeparator: ThousandSeparator.None,
                    leadingSymbol: '',
                    trailingSymbol: ' kg',
                    mantissaLength: 3,
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade';
                  }
                  String quantidadeSemKg = value.replaceAll(' kg', '').trim();
                  double? quantidade = double.tryParse(quantidadeSemKg);

                  if (quantidade == null || quantidade <= 0) {
                    return 'Insira um número válido e maior que zero';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instrucoesParaTrocaController,
                decoration: _inputDecoration('Instruções *'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe as instruções de troca' : null,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: const Text(
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                      'Cancelar',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _proporTroca(
                    sementeDestinatarioTroca,
                    sementeRemetenteTroca,
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: const Text(
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                      'Confirmar',
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sementeController = Provider.of<SementeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trocar por ${widget.sementeSelecionada.semTxNome}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: atualizarBusca,
              decoration: InputDecoration(
                labelText: 'Buscar',
                hintText: 'Nome',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 32, 17, 17), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
          ),
          sementeController.isLoading
              ? _buildLoading()
              : sementeController.sementes.isEmpty
                  ? _buildSemSementes()
                  : _buildList(sementeController),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSemSementes() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Você não possui sementes cadastradas.\n'
            'Para efetuar uma troca, é necessário ter\n'
            'sementes para ofertar.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(SementeController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListView.builder(
          itemCount: controller.sementes.length,
          itemBuilder: (context, index) {
            final semente = controller.sementes[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                leading: ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[100],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.grain,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  semente.semTxNome,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Quantidade: ${semente.semNrQuantidade}',
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _mostrarDialogoTroca(
                      widget.sementeSelecionada, controller.sementes[index]),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: const Text(
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                      'Trocar',
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
