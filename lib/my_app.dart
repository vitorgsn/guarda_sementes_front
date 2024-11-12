import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/Login/login_page.dart';
import 'package:guarda_sementes_front/src/pages/Home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(76, 175, 80, 0.8),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const HomePage(),
      },
    );
  }
}
