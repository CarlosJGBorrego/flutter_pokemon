import 'package:flutter/material.dart';
import 'package:pokemon/pages/pokemon_detail_page.dart';
import '../data/models/pokemon_model.dart';

class FullPokemonList extends StatelessWidget {
  final List<PokemonListItem> filteredPokemon;
  final bool isLoading;
  final ScrollController scrollController;
  final Function loadPokemonList;

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
      child: ListView.builder(
        controller: scrollController,
        itemCount: filteredPokemon.length + (isLoading ? 1 : 0),
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
                    builder: (context) => PokemonDetailPage(pokemon: pokemon),
                  ),
                );
              },
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
