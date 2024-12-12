import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../models/pokemon.dart';
import '../screens/details_screen.dart';

class CardSwiper extends StatelessWidget {
  final List<Pokemon> pokemons;

  const CardSwiper({super.key, required this.pokemons});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (pokemons.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: pokemons.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 1,
        itemHeight: size.height * 1,
        itemBuilder: (BuildContext context, int index) {
          final pokemon = pokemons[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(pokemon: pokemon),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(pokemon.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
