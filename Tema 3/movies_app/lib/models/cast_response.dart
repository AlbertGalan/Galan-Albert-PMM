import 'dart:convert';
import 'actor.dart';

class CastResponse {
  final List<Actor> cast;

  CastResponse({required this.cast});

  factory CastResponse.fromJson(String str) =>
      CastResponse.fromMap(json.decode(str));

  factory CastResponse.fromMap(Map<String, dynamic> json) => CastResponse(
        cast: List<Actor>.from(json['cast'].map((x) => Actor.fromJson(x))),
      );
}
