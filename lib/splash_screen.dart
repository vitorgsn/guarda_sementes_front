import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarda_sementes_front/src/pages/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  late AnimationController _animationController;
  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _nameAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.61),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _nameAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -4.5),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 1), () {
      _animationController.forward();
    });

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(76, 175, 80, 0.8),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: _opacity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SlideTransition(
                position: _logoAnimation,
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.asset('lib/assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SlideTransition(
                position: _nameAnimation,
                child: SizedBox(
                  child: Text(
                    'Guarda Sementes',
                    style: GoogleFonts.bungee(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
