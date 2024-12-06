import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leafy_app/components/appbar.dart';
import 'package:leafy_app/components/appbarbusqueda.dart';
import 'package:leafy_app/components/formulario.dart';


class Mantenedor extends StatefulWidget {
  const Mantenedor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MantenedorState createState() => _MantenedorState();
}

class _MantenedorState extends State<Mantenedor> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BlogScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar Plantas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Mis Plantas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Comunidad',
          ),
        ],
      ),
    );
  }
}





class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchText = ''; // Texto actual del buscador
  bool _isSearching = false; // Estado del buscador
  final TextEditingController _searchController = TextEditingController(); // Controlador del TextField

  @override
  void dispose() {
    _searchController.dispose(); // Limpia el controlador cuando se destruye el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarbusqueda(
        context,
        'Buscar Plantas',
        isSearching: _isSearching,
        searchController: _searchController,
        onSearchToggle: () {
          setState(() {
            _isSearching = !_isSearching;
            if (!_isSearching) {
              _searchController.clear();
              _searchText = ''; // Reinicia el texto de búsqueda
            }
          });
        },
        onSearchTextChanged: (value) {
          setState(() {
            _searchText = value.toLowerCase();
          });
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No hay registros disponibles.'));
                }

                final usuarios = snapshot.data!.docs
                    .where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final nombre = data['nombre']?.toString().toLowerCase() ?? '';
                      return nombre.contains(_searchText);
                    })
                    .toList();

                if (usuarios.isEmpty) {
                  return const Center(child: Text('No se encontraron coincidencias.'));
                }

                return ListView.separated(
                  itemCount: usuarios.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Color.fromARGB(255, 235, 235, 235),
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    final usuario = usuarios[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        '${usuario['nombre']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${usuario['telefono']}'),
                      trailing: const Icon(
                        Icons.yard, // Usamos el ícono de Yard
                        color: Color.fromARGB(255, 56, 135, 130), // Puedes personalizar el color
                        size: 30, // Ajusta el tamaño si es necesario
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
         backgroundColor: const Color.fromARGB(255, 171, 224, 233), // Background color
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: FormularioScreen(),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Lista de plantas
  List<String> plants = List.generate(18, (index) => 'Arapanto ${index + 1}');
  final PageController _pageController = PageController(); // Controlador de páginas
  int _currentPage = 0; // Página actual
  final TextEditingController _searchController = TextEditingController();
  List<String> allPlants = [
    'Arapanto',
    'Cactus',
    'Helecho',
    'Rosa',
    'Tulipán',
    'Lavanda',
  ]; // Plantas disponibles
  List<String> filteredPlants = []; // Plantas filtradas para agregar

  @override
  void initState() {
    super.initState();
    filteredPlants = allPlants; // Inicialmente muestra todas
  }

  void _showAddPlantBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Agregar Planta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      filteredPlants = allPlants
                          .where((plant) =>
                              plant.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Buscar Planta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPlants.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredPlants[index]),
                      trailing: const Icon(Icons.add, color: Colors.green),
                      onTap: () {
                        setState(() {
                          plants.add(filteredPlants[index]);
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int pages = (plants.length / 6).ceil(); // Número de páginas necesarias

    return Scaffold(
       appBar: buildAppBar(context, 'Mis Plantas'),
      body: Stack(
        children: [
          // Contenedor para las tarjetas
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    // Calcula el rango de índices de las tarjetas para esta página
                    final startIndex = pageIndex * 6;
                    final endIndex = (startIndex + 6 > plants.length)
                        ? plants.length
                        : startIndex + 6;

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                        ),
                        itemCount: endIndex - startIndex,
                        itemBuilder: (context, index) {
                          final plantIndex = startIndex + index;
                          return Card(
                            elevation: 4.0,
                            margin: EdgeInsets.zero,
                            child: Column(
                              children: [
                                // Imagen de la planta
                                SizedBox(
                                  height: 130,
                                  width: double.infinity,
                                  child: Image.asset(
                                    'lib/assets/images/Arapanto.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Nombre de la planta y botón more_vert
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          plants[plantIndex],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'Eliminar') {
                                            setState(() {
                                              plants.removeAt(plantIndex);
                                            });
                                          }
                                        },
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 'Editar',
                                            child: Text('Editar'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'Eliminar',
                                            child: Text('Eliminar'),
                                          ),
                                        ],
                                        icon: const Icon(Icons.more_vert),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 60), // Espacio para el botón flotante
            ],
          ),
          // Indicadores de página (puntos deslizantes)
          Positioned(
            bottom: 70, // Ajustado para estar sobre el botón flotante
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages,
                (index) => GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentPage == index ? 10.0 : 6.0,
                    height: _currentPage == index ? 10.0 : 6.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.teal
                          : Colors.teal.shade200,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPlantBottomSheet(context),
        backgroundColor: const Color.fromARGB(255, 171, 224, 233), // Background color
        child: const Icon(Icons.add),
        
      ),
    );
  }
}

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  bool isLiked = false; // Estado inicial del botón de like
  int likeCount = 10; // Contador inicial de likes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Comunidad'),
      body: ListView(
        children: [
          const SizedBox(height: 12.0),
          Container(
            // Usuario
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagen circular
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/usuario.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12.0), // Espacio entre la imagen y el texto
                // Texto al lado
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Maida Villarroel',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Fertilizando con cascara de huevo',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            // Publicación
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Publicado 04/07/2024  -  hace 20 minutos',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 120, 120, 120),
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  'Este tip me lo dio hace mucho tiempo mi mamá y siempre me ha funcionado genial a ustedes que tal les va con este método?',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 102, 102, 102),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  // Imagen
                  height: 350.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/fertilizante.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            // Likes y comentarios
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked; // Cambia el estado de like
                      likeCount += isLiked
                          ? 1
                          : -1; // Incrementa o decrementa el contador
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    color: isLiked
                        ? Colors.red
                        : const Color.fromARGB(255, 0, 0, 0),
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '$likeCount',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 16.0),
                const Icon(
                  Icons.comment,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                const Text(
                  '9',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const ExpandableText(
            text:
                'Tienes que machacarlos y hervirlos y luego riegas con ellos!! es mucho más fácil que la planta absorba los nutrientes!!',
          ),
        ],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 102, 102, 102),
            ),
            maxLines: isExpanded ? 3 : 2, // Alterna entre 2 y 3 líneas
            overflow: TextOverflow
                .ellipsis, // Muestra puntos suspensivos si está truncado
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {}, // Botón "Responder" sin funcionalidad
                child: const Text(
                  'Responder',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                  width: 12), // Espacio de 12 puntos entre los botones
              TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded; // Alterna el estado de expandido
                  });
                },
                child: Text(
                  isExpanded ? 'Ver menos' : 'Ver más',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          

  const SizedBox(height: 15.0),
          Container(
            // Usuario
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagen circular
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/usuariodos.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12.0), // Espacio entre la imagen y el texto
                // Texto al lado
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Anto Villalobos',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Me compré un bonsai espectacular!',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              // Publicacion
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'Publicado 03/07/2024  -  hace un día', // Informacion post
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 120, 120, 120),
                      )),
                  const SizedBox(height: 4.0),
                  const Text(
                      // Post
                      'Les quería mostrar mi lindo bonsai que me compré hace un par de días :)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 102, 102, 102),
                      )),
                  const SizedBox(height: 10.0),
                  Container(
                    // Imagen
                    height: 350.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/bonsai.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(height: 12.0),
          Container(
            // Likes y comentarios
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            child: const Row(
              // Likes y comentarios
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  // Likes
                  Icons.favorite, // Icono de corazón
                  color: Color.fromARGB(255, 0, 0, 0),
                  fill: 0,
                  size: 24,
                ),
                SizedBox(width: 8.0),
                Text(
                  // Cantidad de likes
                  '21',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 16.0),
                Icon(
                  // Icono comentarios
                  Icons.comment, // Icono de comentario
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 24.0, // Tamaño del icono
                ),
                SizedBox(width: 8.0),
                Text(
                  // Cantidad de comentarios
                  '4',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            // Usuario 1 - comentario
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagen circular
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/usuariodosrespuesta.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12.0), // Espacio entre la imagen y el texto
                // Texto al lado
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Publicado  - hace un día',
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 102, 102, 102)),
                    ),
                    Text(
                      'Alex Becker',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              child: const Column(
                // Comentario
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Que bonitooooo',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 102, 102, 102))),
                  Text('Responder     Ver más',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                          color: Colors.blue,
                      ))
                ],
              )),






const SizedBox(height: 15.0),
          Container(
            // Usuario
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagen circular
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/usuariotres.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12.0), // Espacio entre la imagen y el texto
                // Texto al lado
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dario Hurtado',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Se vende planta jade, negociable',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              // Publicacion
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'Publicado 01/07/2024  -  hace tres días', // Informacion post
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 120, 120, 120),
                      )),
                  const SizedBox(height: 4.0),
                  const Text(
                      // Post
                      'precio: 15000, despacho por starken',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 102, 102, 102),
                      )),
                  const SizedBox(height: 10.0),
                  Container(
                    // Imagen
                    height: 350.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/jade.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(height: 12.0),
          Container(
            // Likes y comentarios
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            child: const Row(
              // Likes y comentarios
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  // Likes
                  Icons.favorite, // Icono de corazón
                  color: Color.fromARGB(255, 0, 0, 0),
                  fill: 0,
                  size: 24,
                ),
                SizedBox(width: 8.0),
                Text(
                  // Cantidad de likes
                  '9',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 16.0),
                Icon(
                  // Icono comentarios
                  Icons.comment, // Icono de comentario
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 24.0, // Tamaño del icono
                ),
                SizedBox(width: 8.0),
                Text(
                  // Cantidad de comentarios
                  '2',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            // Usuario 1 - comentario
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagen circular
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/usuariorespuesta.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12.0), // Espacio entre la imagen y el texto
                // Texto al lado
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Publicado  - hace dos días',
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 102, 102, 102)),
                    ),
                    Text(
                      'JM Martínez',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              child: const Column(
                // Comentario
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Hablemos por dm',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 102, 102, 102))),
                  Text('Responder     Ver más',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                          color: Colors.blue,
                      ))
                ],
              )),



        ], 
      ),
    );
  }
}



 




        
        
      
      
    
    
  
  


