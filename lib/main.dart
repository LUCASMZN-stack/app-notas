import 'package:flutter/material.dart';
import 'home_page.dart'; // Importar a HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Notas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/visualizar': (context) => const VisualizarPage(),
        '/agenda': (context) => const AgendaPage(),
        '/cadastrar': (context) => const CadastrarPage(),
      },
    );
  }
}

// Página de Visualizar
class VisualizarPage extends StatelessWidget {
  const VisualizarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visualizar")),
      body: const Center(child: Text("Página de Visualizar")),
    );
  }
}

// Página de Agenda
class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agenda")),
      body: const Center(child: Text("Página de Agenda")),
    );
  }
}

// Página de Cadastrar
class CadastrarPage extends StatelessWidget {
  const CadastrarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastrar")),
      body: const Center(child: Text("Página de Cadastrar")),
    );
  }
}
