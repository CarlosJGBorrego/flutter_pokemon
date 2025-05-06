import 'package:flutter/material.dart'; //UI estandar de flutter
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/repositories/pokemon_repository.dart';
import 'package:pokemon/data/services/favorite_service.dart';
import 'pokemon_detail_page.dart';
import '../widgets/custom_app_bar.dart';

//StatefulWidget para manejar los estados, en nuestro caso pokemonFavoritos
class PokemonFavouritePage extends StatefulWidget {
  const PokemonFavouritePage({super.key});

  @override
  State<PokemonFavouritePage> createState() => _PokemonFavouritePageState();
}

class _PokemonFavouritePageState extends State<PokemonFavouritePage> {
  //Crear el repositorio, llamar al servicio y guardarlos en una lista
  final repository = PokemonRepository();
  final favoriteService = FavoriteService();
  List<PokemonListItem> favorites = [];

  //Cargar los pokemons almacenados en local
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final ids = await favoriteService.getFavorites();
    final List<PokemonListItem> favs = [];
    for (final id in ids) {
      final data = await repository.getPokemonByName(id.toString());
      final pokemon = PokemonListItem.fromJson({
        'name': data['name'],
        'url': 'https://pokeapi.co/api/v2/pokemon/$id',
      });
      await pokemon.pokemonDetails();
      favs.add(pokemon);
    }

    setState(() {
      favorites = favs;
    });
  }

  Future<void> _removeFavorite(int id) async {
    await favoriteService.toggleFavorite(id);
    _loadFavorites(); // recarga la lista
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favoritos'),
      body:
          favorites.isEmpty
              ? Center(
                child: Text(
                  'No hay Pokémon añadidos a la lista.',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              )
              : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final pokemon = favorites[index];
                  return ListTile(
                    leading: Image.network(pokemon.imageUrl ?? ''),
                    title: Text('#${pokemon.id} ${pokemon.name}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeFavorite(pokemon.id!),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PokemonDetailPage(pokemon: pokemon),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
