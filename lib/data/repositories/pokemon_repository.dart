import 'dart:convert'; //Para convertir textoJSON en objetos Dart y viceversa.
import 'package:http/http.dart'
    as http; //Paquete para hacer peticiones HTTP (GET/POST/etc)
import '../models/pokemon_model.dart';

class PokemonRepository {
  final baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<PokemonListItem>> getPokemonList({
    int offset = 0,
    int limit = 20,
  }) async {
    //Llamamos a nuestra API paginando por los limites entre offset y limit
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      //Convertimos el JSON a una lista PokemonListItem
      final decoded = json.decode(response.body);
      final listResponse = PokemonListResponse.fromJson(decoded);
      return listResponse.results;
    } else {
      throw Exception('Error al cargar lista de Pokémon');
    }
  }

  Future<Map<String, dynamic>> getPokemonByName(String name) async {
    //Buscamos un pokemon por el nombre exacto
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));

    if (response.statusCode == 200) {
      //Devuelve un mapa Map<String, dynamic> con todos los datos del Pokemon
      return json.decode(response.body);
    } else {
      throw Exception('No se encontró el Pokémon con nombre: $name');
    }
  }

  Future<void> getPokemonDetails(PokemonListItem pokemon) async {
    //Llamamos a nuestro método PokemonDetails del modelo PokemonListItem
    await pokemon.pokemonDetails();
  }
}
