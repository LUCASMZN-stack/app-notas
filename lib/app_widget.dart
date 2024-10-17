import 'package:flutter/material.dart';
import 'home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Notas'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: const HomePage(),
    );
  }
}