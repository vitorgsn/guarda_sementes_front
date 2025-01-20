import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarda_sementes_front/src/pages/Login/login_page.dart';
import 'package:guarda_sementes_front/src/pages/Home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(76, 175, 80, 0.8), // Cor primária
          secondary: Colors.white, // Cor secundária, se necessário
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 100,
          backgroundColor: const Color.fromRGBO(76, 175, 80, 0.8),
          indicatorColor:
              Colors.transparent, // Cor do indicador do item selecionado
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                );
              }
              return const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              );
            },
          ),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: Colors.black);
              }
              return const IconThemeData(color: Colors.black87);
            },
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(76, 175, 80, 0.8),
          titleTextStyle: GoogleFonts.bungeeInline(
            textStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      builder: (context, child) {
        return SafeArea(child: child!);
      },
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const HomePage()
      },
    );
  }
}
