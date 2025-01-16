import 'package:flutter/material.dart';

class SementesPage extends StatefulWidget {
  const SementesPage({super.key});

  @override
  State<SementesPage> createState() => _SementesPageState();
}

class _SementesPageState extends State<SementesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MINHAS SEMENTES'),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
