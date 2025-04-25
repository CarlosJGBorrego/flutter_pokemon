import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonListResponse {
  final List<PokemonListItem> results;

  PokemonListResponse({required this.results});

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      results: List<PokemonListItem>.from(
        json['results'].map((item) => PokemonListItem.fromJson(item)),
      ),
    );
  }
}

class PokemonListItem {
  final String name;
  final String url;

  String? imageUrl;
  int? id;
  List<String>? types;
  double? height;
  double? weight;

  PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(name: json['name'], url: json['url']);
  }

  Future<void> pokemonDetails() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      id = data['id'];
      imageUrl = data['sprites']['front_default'];
      types =
          (data['types'] as List)
              .map((typeData) => typeData['type']['name'] as String)
              .toList();
      height = (data['height'] ?? 0) / 10.0;
      weight = (data['weight'] ?? 0) / 100.0;
    } else {
      throw Exception('No se pudieron cargar los detalles del Pokémon');
    }
  }
}
