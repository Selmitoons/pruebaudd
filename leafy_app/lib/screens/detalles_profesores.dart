import 'package:flutter/material.dart';

class DetallesUsuarioScreen extends StatelessWidget {
  final Map<String, dynamic> usuario;

  const DetallesUsuarioScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Profesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(usuario['nombre'] ?? '', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'Apellido Paterno:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(usuario['apellido_paterno'] ?? '', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'Apellido Materno:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(usuario['apellido_materno'] ?? '', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'Teléfono:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(usuario['telefono'] ?? '', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
