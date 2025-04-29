import 'package:flutter/material.dart';
import '../data/models/pokemon_model.dart';
import '../data/repositories/pokemon_repository.dart';
import '../widgets/search.dart';
import '../widgets/full_pokemon_list.dart'; // Importamos el nuevo widget
import '../widgets/custom_app_bar.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final PokemonRepository _repository = PokemonRepository();
  final ScrollController _scrollController = ScrollController();

  final List<PokemonListItem> _allPokemon = [];
  List<PokemonListItem> _filteredPokemon = [];

  bool _isLoading = false;
  bool _hasMore = true;
  int _offset = 0;
  final int _limit = 20;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadPokemonList();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadPokemonList(); // Cargar más cuando se acerca al final
    }
  }

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

  void _applyFilter(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredPokemon = List.from(_allPokemon);
      } else {
        _filteredPokemon =
            _allPokemon
                .where(
                  (pokemon) =>
                      pokemon.name.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
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
