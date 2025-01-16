import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/Guardioes/GuardioesPage.dart';
import 'package:guarda_sementes_front/src/pages/Perfil/PerfilPage.dart';
import 'package:guarda_sementes_front/src/pages/Sementes/sementes_disponiveis_troca_page.dart';
import 'package:guarda_sementes_front/src/pages/Sementes/SementesPage.dart';
import 'package:guarda_sementes_front/src/pages/Trocas/TrocasPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          SementesDisponiveisTrocaPage(),
          TrocasPage(),
          GuardioesPage(),
          SementesPage(),
          PerfilPage()
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: paginaAtual,
        onDestinationSelected: (int i) {
          pc.animateToPage(i,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
        destinations: const [
          NavigationDestination(
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.store_outlined,
                size: 40,
              ),
            ),
            selectedIcon: Icon(
              Icons.store,
              size: 60,
            ),
            label: 'Feira',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.handshake_outlined,
                size: 40,
              ),
            ),
            selectedIcon: Icon(
              Icons.handshake,
              size: 60,
            ),
            label: 'Trocas',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.supervised_user_circle_outlined,
                size: 40,
              ),
            ),
            selectedIcon: Icon(
              Icons.supervised_user_circle,
              size: 60,
            ),
            label: 'Guardiões',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.grain_outlined,
                size: 40,
              ),
            ),
            selectedIcon: Icon(
              Icons.grain,
              size: 60,
            ),
            label: 'Sementes',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.account_circle_outlined,
                size: 40,
              ),
            ),
            selectedIcon: Icon(
              Icons.account_circle,
              size: 60,
            ),
            label: 'Perfil',
          )
        ],
      ),
    );
  }
}
