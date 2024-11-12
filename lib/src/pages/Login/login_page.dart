import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarda_sementes_front/src/controllers/authentication_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      AuthenticationController();
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
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
                              style: GoogleFonts.bungeeInline(
                                  color: Colors.white, fontSize: 30),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 20, bottom: 12),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
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
                                          Icons.email,
                                          color:
                                              Color.fromRGBO(76, 175, 80, 0.8),
                                        ),
                                        labelText: 'Email',
                                        border: OutlineInputBorder()),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: _passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: _isObscureText,
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                76, 175, 80, 0.8),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  76, 175, 80, 0.8)),
                                        ),
                                        labelText: 'Senha',
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color:
                                              Color.fromRGBO(76, 175, 80, 0.8),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isObscureText = !_isObscureText;
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
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor),
                                          onPressed: () async {
                                            try {
                                              await _authenticationController
                                                  .login(_emailController.text,
                                                      _passwordController.text);
                                              Navigator.of(context)
                                                  .pushReplacementNamed('/');
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  content: Text(
                                                      'Email ou senha inválidos.'),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                          },
                                          child: const SizedBox(
                                            child: Text(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                                'Entrar'),
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor),
                                          onPressed: () {
                                            debugPrint('ok');
                                          },
                                          child: const SizedBox(
                                            child: Text(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                                'Cadastre-se'),
                                          )),
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
    );
  }
}
