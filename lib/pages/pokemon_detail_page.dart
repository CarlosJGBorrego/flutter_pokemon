import 'package:flutter/material.dart';
import 'package:pokemon/widgets/type_pokemon.dart';
import '../data/models/pokemon_model.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonListItem pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // Centrar todo el contenido
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Centrar la columna
            crossAxisAlignment:
                CrossAxisAlignment
                    .center, // Asegurar que los elementos dentro de la columna se centren
            children: [
              // Imagen del Pokémon
              SizedBox(
                width: 150,
                height: 150,
                child: Image.network(
                  pokemon.imageUrl ?? '',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),

              // ID + Nombre
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '# ${pokemon.id ?? "N/A"}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      pokemon.name[0].toUpperCase() +
                          pokemon.name.substring(1).toLowerCase(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tipos
              Wrap(
                spacing: 6,
                alignment: WrapAlignment.center, // Centrar los Chips
                children:
                    pokemon.types!
                        .map(
                          (type) => Chip(
                            label: Text(
                              getTypeData(type).name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: getTypeData(type).color,
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 16),

              // Altura y Peso en un mismo Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Altura: ${(pokemon.height ?? 0.0).toStringAsFixed(1)} m',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 20), // Espaciado entre Altura y Peso
                  Text(
                    'Peso: ${(pokemon.weight ?? 0.0).toStringAsFixed(1)} kg',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
