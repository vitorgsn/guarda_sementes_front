import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarda_sementes_front/src/controllers/authentication_controller.dart';
import 'package:guarda_sementes_front/src/pages/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final AuthenticationController _authenticationController =
      AuthenticationController();
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 250,
                              child: Image.asset('lib/assets/images/logo.png'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              child: Text(
                                'Guarda Sementes',
                                style: GoogleFonts.bungee(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 30),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _loginController,
                                      keyboardType: TextInputType.name,
                                      style: const TextStyle(fontSize: 20),
                                      decoration: const InputDecoration(
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  76, 175, 80, 0.8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    76, 175, 80, 0.8)),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Color.fromRGBO(
                                                76, 175, 80, 0.8),
                                          ),
                                          labelText: 'Usuário',
                                          border: OutlineInputBorder()),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      controller: _senhaController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      style: const TextStyle(fontSize: 20),
                                      obscureText: _isObscureText,
                                      decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              color: Colors.black),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  76, 175, 80, 0.8),
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    76, 175, 80, 0.8)),
                                          ),
                                          labelText: 'Senha',
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Color.fromRGBO(
                                                76, 175, 80, 0.8),
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isObscureText =
                                                    !_isObscureText;
                                              });
                                            },
                                            child: Icon(
                                              _isObscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: const Color.fromRGBO(
                                                  76, 175, 80, 0.8),
                                            ),
                                          ),
                                          border: const OutlineInputBorder()),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 5,
                                              backgroundColor:
                                                  Colors.lightBlueAccent),
                                          onPressed: () {
                                            debugPrint('ok');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            child: const Text(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.center,
                                                'Cadastre-se'),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 5,
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onPressed: () async {
                                            // Verificar se os campos estão em branco
                                            if (_loginController.text.isEmpty ||
                                                _senhaController.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  content: Text(
                                                    'Por favor, preencha todos os campos!',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                              return;
                                            }

                                            try {
                                              await _authenticationController
                                                  .login(
                                                _loginController.text,
                                                _senhaController.text,
                                              );

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage(),
                                                ),
                                              );
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  content: Text(
                                                    e.toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 15),
                                            child: const Text(
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.center,
                                              'Entrar',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
