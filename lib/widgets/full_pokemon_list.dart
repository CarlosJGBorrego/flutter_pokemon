import 'package:flutter/material.dart'; //UI estándar de Flutter
import 'package:pokemon/pages/pokemon_detail_page.dart';
import '../data/models/pokemon_model.dart';

//No necesitamos manejar estados por lo que usamos StatelessWidget
class FullPokemonList extends StatelessWidget {
  final List<PokemonListItem> filteredPokemon;
  final bool isLoading;
  final ScrollController scrollController;
  final Function loadPokemonList;

  //Parámetros requeridos por el constructor
  const FullPokemonList({
    super.key,
    required this.filteredPokemon,
    required this.isLoading,
    required this.scrollController,
    required this.loadPokemonList,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          filteredPokemon.isEmpty && !isLoading
              ? const Center(child: Text('No se encontraron Pokémon'))
              : ListView.builder(
                controller: scrollController, //controlar el scroll de la lista
                itemCount:
                    filteredPokemon.length +
                    (isLoading
                        ? 1
                        : 0), //Indica cuantos elementos va a mostrar la lista
                itemBuilder: (context, index) {
                  if (index < filteredPokemon.length) {
                    final pokemon = filteredPokemon[index];
                    return ListTile(
                      title: Text(
                        pokemon.name[0].toUpperCase() +
                            pokemon.name.substring(1).toLowerCase(),
                      ),
                      leading: Image.network(pokemon.imageUrl ?? ''),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    PokemonDetailPage(pokemon: pokemon),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } //ItemBuilder -> Es una función que se ejecuta por cada indica de la lista, es util porque lo vamos creando poco a poco para mejorar el rendimiento
                },
              ),
    );
  }
}
