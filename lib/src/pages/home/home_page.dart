import 'package:flutter/material.dart';
import 'package:guarda_sementes_front/src/pages/perfil/perfil_page.dart';
import 'package:guarda_sementes_front/src/pages/armazem/armazem_page.dart';
import 'package:guarda_sementes_front/src/pages/semente/sementes_disponiveis_troca_page.dart';
import 'package:guarda_sementes_front/src/pages/troca/trocas_page.dart';

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
    Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          SementesDisponiveisTrocaPage(),
          TrocasPage(),
          ArmazemPage(),
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
