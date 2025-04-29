import 'package:flutter/material.dart';
import 'package:pokemon/widgets/type_pokemon.dart';
import '../data/models/pokemon_model.dart';
import '../data/services/favorite_service.dart'; // Asegúrate de importar tu servicio

class PokemonDetailPage extends StatefulWidget {
  final PokemonListItem pokemon;
  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  bool isFavorite = false;
  final favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    if (widget.pokemon.id != null) {
      final fav = await favoriteService.isFavorite(widget.pokemon.id!);
      setState(() {
        isFavorite = fav;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (widget.pokemon.id == null) return;
    await favoriteService.toggleFavorite(widget.pokemon.id!);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen
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
              Row(
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
              const SizedBox(height: 16),

              // Tipos
              Wrap(
                spacing: 6,
                alignment: WrapAlignment.center,
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

              // Altura y Peso
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
                  const SizedBox(width: 20),
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
              const SizedBox(height: 24),

              // Botón de favorito debajo del peso y altura
              ElevatedButton.icon(
                onPressed: _toggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                label: Text(
                  isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFavorite ? Colors.red : Colors.blueGrey,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
