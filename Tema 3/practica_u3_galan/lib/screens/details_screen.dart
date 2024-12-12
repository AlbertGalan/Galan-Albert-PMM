import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../models/evolution_chain.dart'; // Importar EvolutionNode
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/card_swiper_details.dart';

class DetailsScreen extends StatelessWidget {
  final Pokemon pokemon;

  const DetailsScreen({super.key, required this.pokemon});

  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).toLowerCase();

  String removeLineBreaks(String text) {
    return text.replaceAll('\n', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalize(pokemon.name)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'NºPdx: #${pokemon.id}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CardSwiperDetails(
              imageUrls: [pokemon.imageUrl, pokemon.shinyImageUrl],
            ),
            const SizedBox(height: 10),
            Text(
              capitalize(pokemon.name),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.typeImages
                  .map((typeImage) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          typeImage,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Column(
                              children: [
                                Icon(Icons.error, size: 50),
                                Text('Error al cargar imagen',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            );
                          },
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                removeLineBreaks(pokemon.species.description),
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Peso:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${pokemon.weight} kg',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Generación:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      pokemon.species.generation.toUpperCase(),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Línea Evolutiva:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchEvolutionData(pokemon.species.evolutionChain.chain),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error al cargar las imágenes de la evolución');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No hay imágenes de la evolución disponibles');
                } else {
                  return Column(
                    children: snapshot.data!.map((evolutionData) {
                      return Column(
                        children: [
                          Text(
                            evolutionData['chain'],
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: evolutionData['images']
                                .map<Widget>((imageUrl) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Image.network(
                                        imageUrl,
                                        width: 50,
                                        height: 50,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.error);
                                        },
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchEvolutionData(
      EvolutionNode node) async {
    List<Map<String, dynamic>> evolutionData = [];

    Future<void> traverseAndFetchData(EvolutionNode node,
        List<String> currentChain, List<String> currentImages) async {
      currentChain.add(capitalize(node.speciesName));
      final response = await http
          .get(Uri.parse(
              'https://pokeapi.co/api/v2/pokemon/${node.speciesName.toLowerCase()}'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final imageUrl =
            data['sprites']['other']['official-artwork']['front_default'];
        currentImages.add(imageUrl);
      }
      if (node.evolvesTo.isEmpty) {
        evolutionData.add({
          'chain': currentChain.join(' -> '),
          'images': currentImages,
        });
      } else {
        for (var nextNode in node.evolvesTo) {
          await traverseAndFetchData(nextNode, List<String>.from(currentChain),
              List<String>.from(currentImages));
        }
      }
    }

    await traverseAndFetchData(node, [], []);
    return evolutionData;
  }
}
