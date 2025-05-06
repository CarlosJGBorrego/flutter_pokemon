import 'package:flutter/material.dart'; //Para acceder a los widgets básicos como Scaffold, Column, etc

class PokemonTypeData {
  final Color color;
  final String name;

  PokemonTypeData({required this.color, required this.name});
}

PokemonTypeData getTypeData(String type) {
  switch (type.toLowerCase()) {
    case 'steel':
      return PokemonTypeData(color: Colors.blueGrey, name: 'Acero');
    case 'water':
      return PokemonTypeData(color: Colors.blueAccent.shade700, name: 'Agua');
    case 'bug':
      return PokemonTypeData(color: Colors.lightGreen, name: 'Bicho');
    case 'dragon':
      return PokemonTypeData(color: Colors.indigoAccent, name: 'Dragón');
    case 'electric':
      return PokemonTypeData(color: Colors.yellow.shade700, name: 'Eléctrico');
    case 'ghost':
      return PokemonTypeData(
        color: Colors.deepPurple.shade800,
        name: 'Fantasma',
      );
    case 'fire':
      return PokemonTypeData(color: Colors.red.shade300, name: 'Fuego');
    case 'fairy':
      return PokemonTypeData(color: Colors.purpleAccent.shade100, name: 'Hada');
    case 'ice':
      return PokemonTypeData(
        color: Colors.lightBlueAccent.shade100,
        name: 'Hielo',
      );
    case 'fighting':
      return PokemonTypeData(color: Colors.orange.shade600, name: 'Lucha');
    case 'normal':
      return PokemonTypeData(color: Colors.grey.shade500, name: 'Normal');
    case 'grass':
      return PokemonTypeData(color: Colors.green, name: 'Planta');
    case 'psychic':
      return PokemonTypeData(color: Colors.purple.shade300, name: 'Psíquico');
    case 'rock':
      return PokemonTypeData(color: Colors.brown, name: 'Roca');
    case 'dark':
      return PokemonTypeData(color: Colors.grey.shade900, name: 'Siniestro');
    case 'ground':
      return PokemonTypeData(
        color: Colors.amberAccent.shade400,
        name: 'Tierra',
      );
    case 'poison':
      return PokemonTypeData(color: Colors.purple.shade800, name: 'Veneno');
    case 'flying':
      return PokemonTypeData(
        color: Colors.blueAccent.shade100,
        name: 'Volador',
      );

    default:
      return PokemonTypeData(color: Colors.brown.shade100, name: 'Desconocido');
  }
}
