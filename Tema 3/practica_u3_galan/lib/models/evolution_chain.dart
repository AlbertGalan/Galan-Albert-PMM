import 'dart:convert';

EvolutionChain evolutionChainFromJson(String str) =>
    EvolutionChain.fromJson(json.decode(str));

String evolutionChainToJson(EvolutionChain data) => json.encode(data.toJson());

class EvolutionChain {
  EvolutionChain({
    required this.chain,
  });

  EvolutionNode chain;

  factory EvolutionChain.fromJson(Map<String, dynamic> json) => EvolutionChain(
        chain: EvolutionNode.fromJson(json["chain"]),
      );

  Map<String, dynamic> toJson() => {
        "chain": chain.toJson(),
      };
}

class EvolutionNode {
  EvolutionNode({
    required this.speciesName,
    required this.evolvesTo,
  });

  String speciesName;
  List<EvolutionNode> evolvesTo;

  // Crear un objecte EvolutionNode a partir d'un mapa JSON
  factory EvolutionNode.fromJson(Map<String, dynamic> json) => EvolutionNode(
        speciesName: json["species"]["name"],
        evolvesTo: List<EvolutionNode>.from(
            json["evolves_to"].map((x) => EvolutionNode.fromJson(x))),
      );

  // Convertir un objecte EvolutionNode a un mapa JSON
  Map<String, dynamic> toJson() => {
        "species": {"name": speciesName},
        "evolves_to": List<dynamic>.from(evolvesTo.map((x) => x.toJson())),
      };
}
