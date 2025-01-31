import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarda_sementes_front/src/pages/login/login_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(Object context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(76, 175, 80, 0.8),
          secondary: Colors.white,
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 100,
          backgroundColor: const Color.fromRGBO(76, 175, 80, 0.8),
          indicatorColor: Colors.transparent,
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
