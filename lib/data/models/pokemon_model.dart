import 'package:http/http.dart'
    as http; //Paquete para hacer peticiones HTTP (GET/POST/etc)
import 'dart:convert'; //Para convertir textoJSON en objetos Dart y viceversa.

class PokemonListResponse {
  //Esta clase es la respuesta de la API cuando pides la lista de pokemons
  final List<PokemonListItem> results;

  PokemonListResponse({required this.results});

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    //Convertimos un mapa JSON en un objeto
    return PokemonListResponse(
      results: List<PokemonListItem>.from(
        json['results'].map((item) => PokemonListItem.fromJson(item)),
      ),
    );
  }
}

class PokemonListItem {
  //Estos valores vienen de la primera peticion de la API de pokemon
  final String name;
  final String url;

  //Estos datos los obtenemos a partir de la url que obtenemos en la primera petición
  //como son detalles que cargan mas adelante o despues de una acción, los ponemos como opcionales
  String? imageUrl;
  int? id;
  List<String>? types;
  double? height;
  double? weight;

  PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    //Convertimos la respuesta {name, url} en un objeto PokemonListItem
    return PokemonListItem(name: json['name'], url: json['url']);
  }

  Future<void> pokemonDetails() async {
    //Realizamos una llamada a la url del pokemon individual
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //Convertimos el JSON en un mapa Dart
      final data = json.decode(response.body);
      //Extraemos todos los detalles
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
