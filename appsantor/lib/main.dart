import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,

//THEME DE TOP BAR
theme: ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 90, 96, 108), //color de la appbar
    foregroundColor: Colors.white, //color del texto en app bar blanco
  ),
),

//TOP BAR (SIEMPRE TIENE QUE IR DENTRO DEL SCAFFOLD)
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Z.INGENIERÍA'),
          leading: const Icon(Icons.arrow_back),
        ),

      body: SingleChildScrollView(
        child: Column(
          children: [
      
//CONTAINER GRIS 1
      Container(
        height: 240.0, //altura de 148 pixeles
        width: double.infinity, //ocupa todo el ancho disponible
        color: const Color.fromARGB(255, 202, 202, 218), //color de fondo gris
      ),

const SizedBox(height: 12.0), //Espacio de 12 pixeles entre los containers
      
      //CONTAINERS DOBLE
      Container(  
        height: 250.0, //altura de 148 pixeles
        color: Colors.transparent, //color de fondo transparente para la separación
        
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 165, 165, 178), //color de fondo gris
              ),
            ),
    
            const SizedBox(width: 12.0), //espacio de 12 pixeles entre containers

            Expanded(
              child: Container(
                  color: Color.fromARGB(255, 165, 165, 178), //color de fondo gris
              ),
            ),
          ],
        ),
      ),

const SizedBox(height: 12.0), //Espacio de 12 pixeles entre los containers

//CONTAINER GRIS 3 (DESCRIPCIÓN)
Container(
        height: 100, //altura de 148 pixeles
        width: double.infinity, //ocupa todo el ancho disponible
        color: Color.fromARGB(255, 202, 202, 218), //color de fondo gris
      ), 
      const SizedBox(height: 12.0), //Espacio de 12 pixeles entre los containers

//CONTAINER VERDE
Container(
        height: 40, //altura de 148 pixeles
        width: double.infinity, //ocupa todo el ancho disponible
        color: Color.fromARGB(255, 71, 89, 84), //color de fondo verde
      ), 
       const SizedBox(height: 12.0), //Espacio de 12 pixeles entre los containers

//CONTAINER GRIS 5 (BOTTOM BAR)
Container(
        height: 50, //altura de 148 pixeles
        width: double.infinity, //ocupa todo el ancho disponible
        color: Color.fromARGB(255, 202, 202, 218), //color de fondo gris
      ), 
    ],

          
        ),

      ),
      ),
    );
  }
}