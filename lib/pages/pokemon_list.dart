import 'package:flutter/material.dart'; //UI estándar de Flutter
import '../data/models/pokemon_model.dart';
import '../data/repositories/pokemon_repository.dart';
import '../widgets/search.dart';
import '../widgets/full_pokemon_list.dart';
import '../widgets/custom_app_bar.dart';

//StatefulWidget para manejar los estados, en nuestro caso, pokemonFavoritos
class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  //Obtener datos y controlar el scroll
  final PokemonRepository _repository = PokemonRepository();
  final ScrollController _scrollController = ScrollController();

  final List<PokemonListItem> _allPokemon = [];
  List<PokemonListItem> _filteredPokemon = [];

  bool _isLoading = false;
  bool _hasMore = true;
  int _offset = 0;
  final int _limit = 20;
  String _searchQuery = '';

  //Al iniciar carga la primera tanda de pokemons y activa el listener para cargar mas al hacer scroll
  @override
  void initState() {
    super.initState();
    _loadPokemonList();
    _scrollController.addListener(_onScroll);
  }

  //Limpia el controller cuando se destruye la pantalla
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //Scroll infinito
  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadPokemonList(); // Cargar más cuando se acerca al final
    }
  }

  //Cargar lista de pokemons
  Future<void> _loadPokemonList() async {
    setState(() => _isLoading = true);
    try {
      final newList = await _repository.getPokemonList(
        offset: _offset,
        limit: _limit,
      );

      await Future.wait(
        newList.map((pokemon) => _repository.getPokemonDetails(pokemon)),
      );

      if (!mounted) return;

      setState(() {
        _offset += _limit;
        _allPokemon.addAll(newList);
        _hasMore = newList.length == _limit;
        _applyFilter(_searchQuery); // aplicar filtro si lo hay
        _isLoading = false;

        print("Offset: $_offset, Total: ${_allPokemon.length}");
      });
    } catch (e) {
      print("Error: $e");
      setState(() => _isLoading = false);
    }
  }

  //Filtro de búsqueda
  void _applyFilter(String query) async {
    setState(() {
      _searchQuery = query;
      _filteredPokemon = [];
    });

    if (query.isEmpty) {
      setState(() {
        _filteredPokemon = List.from(_allPokemon);
      });
    } else {
      // Buscar coincidencias parciales en los que ya tienes
      final localResults =
          _allPokemon
              .where(
                (pokemon) =>
                    pokemon.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

      if (localResults.isNotEmpty) {
        setState(() {
          _filteredPokemon = localResults;
        });
      } else if (query.length >= 3) {
        // Si no hay resultados y el usuario ha escrito al menos 3 letras
        try {
          final result = await _repository.getPokemonByName(
            query.toLowerCase(),
          );
          final pokemon = PokemonListItem(
            name: result['name'],
            url: '${_repository.baseUrl}/pokemon/${result['id']}',
          );
          await _repository.getPokemonDetails(pokemon);

          setState(() {
            _filteredPokemon = [pokemon];
          });
        } catch (e) {
          print('Pokémon no encontrado: $e');
          setState(() {
            _filteredPokemon = []; // No encontrado
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favoritos'),
      body: Column(
        children: [
          CustomerSearchBar(onChanged: _applyFilter),
          const SizedBox(height: 10),
          FullPokemonList(
            filteredPokemon: _filteredPokemon,
            isLoading: _isLoading,
            scrollController: _scrollController,
            loadPokemonList: _loadPokemonList,
          ),
        ],
      ),
    );
  }
}
