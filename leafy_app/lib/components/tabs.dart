import 'package:flutter/material.dart';

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Demo'),
          bottom: const TabBar(
            indicatorColor: Colors.white, // Color de la barra inferior
            labelColor: Colors.white, // Texto seleccionado
            unselectedLabelColor: Colors.white70, // Texto no seleccionado
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold, // Bold para texto seleccionado
              fontSize: 16,
            ),
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Living')),
            Center(child: Text('Cocina')),
            Center(child: Text('Terraza')),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TabBarExample(),
  ));
}