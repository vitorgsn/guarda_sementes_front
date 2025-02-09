import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/my_app.dart';
import 'package:guarda_sementes_front/src/controllers/armazem_controller.dart';
import 'package:guarda_sementes_front/src/controllers/authentication_controller.dart';
import 'package:guarda_sementes_front/src/controllers/categoria_armazem_controller.dart';
import 'package:guarda_sementes_front/src/controllers/cidade_controller.dart';
import 'package:guarda_sementes_front/src/controllers/contato_controller.dart';
import 'package:guarda_sementes_front/src/controllers/endereco_controller.dart';
import 'package:guarda_sementes_front/src/controllers/semente_controller.dart';
import 'package:guarda_sementes_front/src/controllers/semente_disponivel_troca_controller.dart';
import 'package:guarda_sementes_front/src/controllers/troca_controller.dart';
import 'package:guarda_sementes_front/src/controllers/usuario_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthenticationController(),
      ),
      ChangeNotifierProvider(
        create: (context) => SementeController(),
      ),
      ChangeNotifierProvider(
        create: (context) => ArmazemController(),
      ),
      ChangeNotifierProvider(
        create: (context) => UsuarioController(),
      ),
      ChangeNotifierProvider(
        create: (context) => SementeDisponivelTrocaController(),
      ),
      ChangeNotifierProvider(
        create: (context) => EnderecoController(),
      ),
      ChangeNotifierProvider(
        create: (context) => CidadeController(),
      ),
      ChangeNotifierProvider(
        create: (context) => ContatoController(),
      ),
      ChangeNotifierProvider(
        create: (context) => CategoriaArmazemController(),
      ),
      ChangeNotifierProvider(
        create: (context) => TrocaController(),
      ),
    ],
    child: const MyApp(),
  ));
}
