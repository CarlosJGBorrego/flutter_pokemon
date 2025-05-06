import 'package:flutter/material.dart'; //Para acceder a los widgets básicos como Scaffold, Column, etc
import '../widgets/custom_app_bar.dart';

//StatelessWidgets significa que no tiene estado, solo mostramos contenido estático
class HomePage extends StatelessWidget {
  //Permite pasa una clave en caso de si es necesario para identificar el widget en el árbol
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Scaffold -> Estructura básica para una pantalla en Flutter
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favoritos'),
      backgroundColor: Colors.yellow[50], // Fondo claro y agradable
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/pokemon_intro.png', height: 300),
              const Text(
                '¡Bienvenido al mundo Pokémon!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Explora y atrápalos todos',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
