import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonRepository {
  final baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<PokemonListItem>> getPokemonList({
    int offset = 0,
    int limit = 20,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final listResponse = PokemonListResponse.fromJson(decoded);
      return listResponse.results;
    } else {
      throw Exception('Error al cargar lista de Pokémon');
    }
  }

  Future<Map<String, dynamic>> getPokemonByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('No se encontró el Pokémon con nombre: $name');
    }
  }

  Future<void> getPokemonDetails(PokemonListItem pokemon) async {
    await pokemon.pokemonDetails();
  }
}
