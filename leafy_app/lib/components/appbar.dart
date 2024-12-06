import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    leading: IconButton(
      icon: const Icon(
        Icons.menu, // Ícono de menú
        color: Colors.white,
      ),
      onPressed: () {
        // Acción al presionar el ícono de menú
        Scaffold.of(context).openDrawer();
      },
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.settings, // Ícono de configuración
          color: Colors.white,
        ),
        onPressed: () {
          // Acción al presionar el ícono de configuración
          Navigator.pushNamed(context, '/settings');
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.more_vert, // Ícono de "más opciones"
          color: Colors.white,
        ),
        onPressed: () {
          // Acción al presionar el ícono de "más opciones"
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Información'),
                  ),
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Ayuda'),
                  ),
                ],
              );
            },
          );
        },
      ),
    ],
  );
}
