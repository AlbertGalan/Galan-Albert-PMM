import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pokemon.dart';
import '../providers/pokemon_provider.dart';
import '../screens/details_screen.dart';

class PokemonSearchDelegate extends SearchDelegate<Pokemon?> {
  @override
  String get searchFieldLabel => 'Buscar Pokémon';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final pokemonProvider =
        Provider.of<PokemonProvider>(context, listen: false);
    final List<Pokemon> results = pokemonProvider.pokemons
        .where((pokemon) =>
            pokemon.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final pokemon = results[index];
        return ListTile(
          leading: Image.network(pokemon.imageUrl),
          title: Text(pokemon.name),
          subtitle: Text('NºPdx: #${pokemon.id}'),
          onTap: () {
            close(context, pokemon);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(pokemon: pokemon),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final pokemonProvider =
        Provider.of<PokemonProvider>(context, listen: false);
    final List<Pokemon> suggestions = pokemonProvider.pokemons
        .where((pokemon) =>
            pokemon.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final pokemon = suggestions[index];
        return ListTile(
          leading: Image.network(pokemon.imageUrl),
          title: Text(pokemon.name),
          subtitle: Text('NºPdx: #${pokemon.id}'),
          onTap: () {
            query = pokemon.name;
            showResults(context);
          },
        );
      },
    );
  }
}
