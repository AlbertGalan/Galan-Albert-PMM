import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart' as provider;
import '../widgets/pokemon_slider.dart';
import '../widgets/card_swiper.dart';
import '../search/pokemon_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pokemonProvider =
          Provider.of<provider.PokemonProvider>(context, listen: false);
      pokemonProvider.fetchPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<provider.PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PokemonSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: pokemonProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  CardSwiper(pokemons: pokemonProvider.pokemons),
                  PokemonSlider(
                      pokemons: pokemonProvider.pokemons,
                      title: 'Todos los Pokémon'),
                  PokemonSlider(
                      pokemons: pokemonProvider.generationIPokemons,
                      title: 'Pokémon 1a Generación'),
                  PokemonSlider(
                      pokemons: pokemonProvider.generationIIPokemons,
                      title: 'Pokémon 2a Generación'),
                  PokemonSlider(
                      pokemons: pokemonProvider.generationIIIPokemons,
                      title: 'Pokémon 3a Generación'),
                ],
              ),
            ),
    );
  }
}
