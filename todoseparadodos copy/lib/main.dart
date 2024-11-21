// main.dart
import 'package:flutter/material.dart';
import 'package:todoseparadodos/screens/splashscreen.dart'; // Importa el archivo splashscreen.dart
import 'package:todoseparadodos/screens/chats.dart'; // Importa el archivo chats.dart
import 'package:todoseparadodos/theme/theme.dart'; // Importa el tema

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme, // Usa el tema claro
      darkTheme: AppTheme.lightTheme, // Usa el tema oscuro
      themeMode: ThemeMode.system, // Cambia según la configuración del sistema
      home: const SplashScreen(), // La primera pantalla será el SplashScreen
    );
  }
}

// Aquí tienes la pantalla que será el home después del splash
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatsScreen(); // Usa el ChatsScreen en lugar de la lista
  }
}
