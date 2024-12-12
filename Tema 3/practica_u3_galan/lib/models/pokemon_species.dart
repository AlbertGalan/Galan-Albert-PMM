import 'dart:convert';
import 'evolution_chain.dart';

//Convertir una cadena JSON a un objecte PokemonSpecies
PokemonSpecies pokemonSpeciesFromJson(
        String str, EvolutionChain evolutionChain) =>
    PokemonSpecies.fromJson(json.decode(str), evolutionChain);

String pokemonSpeciesToJson(PokemonSpecies data) => json.encode(data.toJson());

class PokemonSpecies {
  PokemonSpecies({
    required this.description,
    required this.generation,
    required this.evolutionChainUrl,
    required this.evolutionChain,
  });

  String description;
  String generation;
  String evolutionChainUrl;
  EvolutionChain evolutionChain;

// A partir des json cream un objecte
  factory PokemonSpecies.fromJson(
      Map<String, dynamic> json, EvolutionChain evolutionChain) {
    String description = '';
    if (json['flavor_text_entries'] != null &&
        json['flavor_text_entries'].isNotEmpty) {
      //Cercar descripció en castellà
      for (var entry in json['flavor_text_entries']) {
        if (entry['language']['name'] == 'es') {
          description = entry['flavor_text'];
          break;
        }
      }
      if (description.isEmpty) {
        description = json['flavor_text_entries'][0]['flavor_text'];
      }
    }

    return PokemonSpecies(
      description: description,
      generation: json['generation']['name'],
      evolutionChainUrl: json['evolution_chain']['url'],
      evolutionChain: evolutionChain,
    );
  }

  // Convertir objecte PokemonSpecies a un mapa JSON
  Map<String, dynamic> toJson() => {
        'description': description,
        'generation': generation,
        'evolution_chain_url': evolutionChainUrl,
        'evolution_chain': evolutionChain.toJson(),
      };
}
