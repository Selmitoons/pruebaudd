import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    leading: IconButton(
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      onPressed: () {
       
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
          Icons.settings,
          color: Colors.white,
        ),
        onPressed: () {
         
          Navigator.pushNamed(context, '/settings');
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.more_vert, 
          color: Colors.white,
        ),
        onPressed: () {
         
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
