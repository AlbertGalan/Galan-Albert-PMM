import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pokemon.dart';
import '../models/pokemon_species.dart';
import '../models/evolution_chain.dart';

class PokemonProvider with ChangeNotifier {
  List<Pokemon> _pokemons = [];
  List<Pokemon> _generationIPokemons = [];
  List<Pokemon> _generationIIPokemons = [];
  List<Pokemon> _generationIIIPokemons = [];
  int _offset = 0;
  final int _limit = 386; // Limit de Pokémon
  bool _isLoading = false;

  List<Pokemon> get pokemons => _pokemons;
  List<Pokemon> get generationIPokemons => _generationIPokemons;
  List<Pokemon> get generationIIPokemons => _generationIIPokemons;
  List<Pokemon> get generationIIIPokemons => _generationIIIPokemons;
  bool get isLoading => _isLoading;
//Fetch per aconseguir els pokemon de la API
  Future<void> fetchPokemons() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?limit=$_limit&offset=$_offset'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      final List<Pokemon> newPokemons =
          await Future.wait(results.map((result) async {
        final pokemonResponse = await http.get(Uri.parse(result['url']));
        if (pokemonResponse.statusCode == 200) {
          final pokemonData = json.decode(pokemonResponse.body);

          // Fetch de species
          final speciesUrl = pokemonData['species']['url'];
          final speciesResponse = await http.get(Uri.parse(speciesUrl));
          if (speciesResponse.statusCode == 200) {
            final speciesData = json.decode(speciesResponse.body);

            // Fetch de evolution chain
            final evolutionChainUrl = speciesData['evolution_chain']['url'];
            final evolutionChainResponse =
                await http.get(Uri.parse(evolutionChainUrl));
            if (evolutionChainResponse.statusCode == 200) {
              final evolutionChainData =
                  json.decode(evolutionChainResponse.body);
              final evolutionChain =
                  EvolutionChain.fromJson(evolutionChainData);

              final species =
                  PokemonSpecies.fromJson(speciesData, evolutionChain);

              // Fetch type images
              List<String> typeImages = [];
              for (var type in pokemonData['types']) {
                final typeUrl = type['type']['url'];
                final typeResponse = await http.get(Uri.parse(typeUrl));
                if (typeResponse.statusCode == 200) {
                  final typeData = json.decode(typeResponse.body);
                  if (typeData.containsKey('sprites') &&
                      typeData['sprites'].containsKey('generation-viii') &&
                      typeData['sprites']['generation-viii']
                          .containsKey('sword-shield') &&
                      typeData['sprites']['generation-viii']['sword-shield']
                          .containsKey('name_icon')) {
                    final typeImage = typeData['sprites']['generation-viii']
                        ['sword-shield']['name_icon'];
                    typeImages.add(typeImage);
                  }
                }
              }

              final pokemon =
                  Pokemon.fromJson(pokemonData, species, typeImages);

              // Filtrar per generació
              if (pokemon.species.generation == 'generation-i') {
                _generationIPokemons.add(pokemon);
              }
              if (pokemon.species.generation == 'generation-ii') {
                _generationIIPokemons.add(pokemon);
              }
              if (pokemon.species.generation == 'generation-iii') {
                _generationIIIPokemons.add(pokemon);
              }

              return pokemon;
            } else {
              throw Exception(
                  'Failed to load evolution chain details: ${evolutionChainResponse.statusCode} ${evolutionChainResponse.body}');
            }
          } else {
            throw Exception(
                'Failed to load pokemon species details: ${speciesResponse.statusCode} ${speciesResponse.body}');
          }
        } else {
          throw Exception(
              'Failed to load pokemon details: ${pokemonResponse.statusCode} ${pokemonResponse.body}');
        }
      }).toList());

      _pokemons.addAll(newPokemons);
      _pokemons.sort((a, b) => a.id.compareTo(b.id));
      _generationIPokemons.sort((a, b) => a.id.compareTo(b.id));
      _generationIIPokemons.sort((a, b) => a.id.compareTo(b.id));
      _generationIIIPokemons.sort((a, b) => a.id.compareTo(b.id));
      _offset += _limit;
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      throw Exception(
          'Failed to load pokemons: ${response.statusCode} ${response.body}');
    }
  }

  Future<void> loadMorePokemons() async {
    if (_isLoading) return;
    await fetchPokemons();
  }
}
