import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/my_app.dart';
import 'package:guarda_sementes_front/src/controllers/authentication_controller.dart';
import 'package:guarda_sementes_front/src/controllers/semente_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthenticationController()),
      ChangeNotifierProvider(create: (context) => SementeController()),
    ],
    child: const MyApp(),
  ));
}
