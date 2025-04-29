import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const _key = 'favorite_pokemon_ids';

  Future<Set<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)?.map(int.parse).toSet() ?? {};
  }

  Future<void> toggleFavorite(int pokemonId) async {
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
    final favorites = await getFavorites();
    return favorites.contains(pokemonId);
  }
}
