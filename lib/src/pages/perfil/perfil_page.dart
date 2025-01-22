import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/controllers/authentication_controller.dart';
import 'package:guarda_sementes_front/src/pages/perfil/contato_page.dart';
import 'package:guarda_sementes_front/src/pages/perfil/endereco_page.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final AuthenticationController _authenticationController =
      AuthenticationController();

  @override
  Widget build(BuildContext context) {
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
                // Foto de Perfil
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/profile_picture.png'),
                ),
                const SizedBox(height: 16),

                // Nome do usuário
                const Text(
                  'Nome do Usuário',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Email ou outros detalhes
                const Text(
                  'email@dominio.com',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                // Botão para editar perfil
                ElevatedButton(
                  onPressed: () {
                    // Lógica para editar perfil
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Editar Perfil'),
                ),
                const SizedBox(height: 16),

                // Botão para lista de endereços
                ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de endereços
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnderecoPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Ver Endereços'),
                ),
                const SizedBox(height: 16),

                // Botão para lista de contatos
                ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de contatos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContatoPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Ver Contatos'),
                ),
                const SizedBox(height: 16),
                // Botão para lista de contatos
                ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Sair'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
