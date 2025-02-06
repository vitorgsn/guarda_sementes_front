import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/authentication_controller.dart';
import 'package:guarda_sementes_front/src/controllers/usuario_controller.dart';
import 'package:guarda_sementes_front/src/pages/contato/contato_page.dart';
import 'package:guarda_sementes_front/src/pages/endereco/endereco_page.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final AuthenticationController _authenticationController =
      AuthenticationController();

  @override
  void initState() {
    super.initState();
    _getUsuario();
  }

  Future<void> _getUsuario() async {
    final usuarioController =
        Provider.of<UsuarioController>(context, listen: false);
    await usuarioController.getUsuario();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioController = Provider.of<UsuarioController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PERFIL'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: usuarioController.usuario?.usuTxNome != null &&
                          usuarioController.usuario!.usuTxNome.isNotEmpty
                      ? Text(
                          usuarioController.usuario!.usuTxNome[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  usuarioController.usuario?.usuTxNome ?? 'Carregando...',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EnderecoPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15),
                        child: const Text(
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                          'Endereços',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContatoPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15),
                        child: const Text(
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                          'Contatos',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        try {
                          await _authenticationController.logout();
                          Navigator.of(context).pushReplacementNamed('/login');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text('Falha ao fazer logout'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15),
                        child: const Text(
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                          'Sair',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
