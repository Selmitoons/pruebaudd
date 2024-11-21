import 'package:flutter/material.dart';
import 'package:todoseparadodos/components/appbar.dart'; // Importa el tema

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ChatsListScreen(),
    const UpdateScreen(),
    const CommunityScreen(),
    const CallsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Cambiado para que solo el body cambie
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Update',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Comunidad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Llamadas',
          ),
        ],
      ),
    );
  }
}

// Pantalla para mostrar la lista de chats
class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context), // AppBar solo en esta pantalla
      body: ListView(
      children: const [
       ListTile(
            leading: CircleAvatar(child: Text('G')), // Germán
            title: Text('Germán', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('S')), // Sofía
            title: Text('Sofía', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('P')), // Pedro
            title: Text('Pedro', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('I')), // Isidora
            title: Text('Isidora', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('A')), // Antonia
            title: Text('Antonia', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('B')), // Benjamín
            title: Text('Benjamín', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('J')), // Josefina
            title: Text('Josefina', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('S')), // Sophia
            title: Text('Sophia', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('D')), // Daniela
            title: Text('Daniela', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('A')), // Axel
            title: Text('Axel', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('F')), // Francisca
            title: Text('Francisca', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('G')), // Germán
            title: Text('Germán', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('S')), // Sofía
            title: Text('Sofía', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('P')), // Pedro
            title: Text('Pedro', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('I')), // Isidora
            title: Text('Isidora', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('A')), // Antonia
            title: Text('Antonia', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('B')), // Benjamín
            title: Text('Benjamín', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('J')), // Josefina
            title: Text('Josefina', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('S')), // Sophia
            title: Text('Sophia', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('D')), // Daniela
            title: Text('Daniela', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('A')), // Axel
            title: Text('Axel', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: CircleAvatar(child: Text('F')), // Francisca
            title: Text('Francisca', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.more_vert),
            tileColor: Colors.white,
          ),
        
      ],
      ),
    );
  }
}
class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizaciones'), // Título de la barra
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Aquí puedes dejar vacío si no deseas navegar
          },
        ),
      ),
      body: const Center(child: Text('Actualizaciones')),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidad'), // Título de la barra
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Aquí puedes dejar vacío si no deseas navegar
          },
        ),
      ),
      body: const Center(child: Text('Comunidad')),
    );
  }
}

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Llamadas'), // / Título de la barra
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Aquí puedes dejar vacío si no deseas navegar
          },
        ),
      ),
      body: const Center(child: Text('Llamadas')),
    );
  }
}