import 'package:flutter/material.dart';

AppBar buildAppBarbusqueda(
  BuildContext context,
  String title, {
  required bool isSearching,
  required TextEditingController searchController,
  required VoidCallback onSearchToggle,
  required ValueChanged<String> onSearchTextChanged,
}) {
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
    title: isSearching
        ? TextField(
            controller: searchController,
            onChanged: onSearchTextChanged,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: 'Buscar...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            autofocus: true,
          )
        : Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
    actions: [
      IconButton(
        icon: Icon(
          isSearching ? Icons.close : Icons.search,
          color: Colors.white,
        ),
        onPressed: onSearchToggle, 
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
