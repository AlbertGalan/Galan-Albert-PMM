import 'dart:convert';
import 'pokemon_species.dart';

Pokemon pokemonFromJson(
        String str, PokemonSpecies species, List<String> typeImages) =>
    Pokemon.fromJson(json.decode(str), species, typeImages);

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.typeImages,
    required this.imageUrl,
    required this.shinyImageUrl,
    required this.weight,
    required this.species,
  });

  int id;
  String name;
  List<String> types;
  List<String> typeImages;
  String imageUrl;
  String shinyImageUrl;
  double weight;
  PokemonSpecies species;

  factory Pokemon.fromJson(Map<String, dynamic> json, PokemonSpecies species,
      List<String> typeImages) {
    List<String> types = [];
    if (json['types'] != null && json['types'].isNotEmpty) {
      types = (json['types'] as List)
          .map<String>((type) => type['type']['name'] as String)
          .toList();
    }

    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: types,
      typeImages: typeImages,
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      shinyImageUrl: json['sprites']['other']['official-artwork']
          ['front_shiny'],
      weight: json['weight'] / 10.0,
      species: species,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "types": types,
        "typeImages": typeImages,
        "imageUrl": imageUrl,
        "shinyImageUrl": shinyImageUrl,
        "weight": weight,
        "species": species.toJson(),
      };
}
