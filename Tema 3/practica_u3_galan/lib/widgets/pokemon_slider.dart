import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../screens/details_screen.dart';

class PokemonSlider extends StatelessWidget {
  final List<Pokemon> pokemons;
  final String title;

  const PokemonSlider({super.key, required this.pokemons, required this.title});
// Primera lletra del Pokémon sempre en majúscules
  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).toLowerCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pokemons.length,
              itemBuilder: (_, int index) => _PokemonPoster(
                  pokemon: pokemons[index], capitalize: capitalize),
            ),
          ),
        ],
      ),
    );
  }
}

class _PokemonPoster extends StatelessWidget {
  final Pokemon pokemon;
  final String Function(String) capitalize;

  const _PokemonPoster(
      {super.key, required this.pokemon, required this.capitalize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(pokemon: pokemon),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                pokemon.imageUrl,
                fit: BoxFit.contain,
                width: 130,
                height: 150,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '#${pokemon.id}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            capitalize(pokemon.name),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
