import 'package:shared_preferences/shared_preferences.dart';
//Libreria que nos permite guardar datos clave-valor localmente

class FavoriteService {
  //Clave para guardar los pokemon favoritos almacenados del local
  static const _key = 'favorite_pokemon_ids';

  Future<Set<int>> getFavorites() async {
    //Obtiene la lista guardadd en _key como una lista de Strings y la convierte en Set<int>
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)?.map(int.parse).toSet() ?? {};
  }

  Future<void> toggleFavorite(int pokemonId) async {
    //Añadimos o quitamos los pokemons favoritos
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    if (favorites.contains(pokemonId)) {
      favorites.remove(pokemonId);
    } else {
      favorites.add(pokemonId);
    }
    await prefs.setStringList(
      _key,
      favorites.map((e) => e.toString()).toList(),
    );
  }

  Future<bool> isFavorite(int pokemonId) async {
    //Devuelve true o false si el pokemon con ese ID está en la lista de favoritos
    final favorites = await getFavorites();
    return favorites.contains(pokemonId);
  }
}
