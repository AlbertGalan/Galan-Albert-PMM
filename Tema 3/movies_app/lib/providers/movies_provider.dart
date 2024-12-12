import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/now_playing_response.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/models/cast_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'en-US';
  final String _page = '1';
  final Map<String, String> _headers = {
    'accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MmViOWM5NTZmOTUzZTQ5MTM4MmU0ZTUzZjA2ZTlhOCIsIm5iZiI6MTczMjEwMjAwMS4zMjA5OTk5LCJzdWIiOiI2NzNkYzc3MWIyMzA1NDg5OGRhMzhjMjIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.rrm2K4-HrkIe-n7D_TtBqZU36H7SVo4RAvb8JHaYBRo'
  };

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider');
    getOnDisplayMovies();
    getPopularMovies();
  }

  void getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'language': _language,
      'page': _page,
    });

    print('Fetching now playing movies...');
    var response = await http.get(url, headers: _headers);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    print('Now playing movies fetched: ${onDisplayMovies[0].title}');
    notifyListeners();
  }

  void getPopularMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/popular', {
      'language': _language,
      'page': _page,
    });

    // Await the http get response, then decode the json-formatted response.
    print('Fetching popular movies...');
    var response = await http.get(url, headers: _headers);
    final popularResponse = NowPlayingResponse.fromJson(response.body);
    popularMovies = popularResponse.results;
    print('Popular movies fetched: ${popularMovies[0].title}');
    notifyListeners();
  }

  Future<List<Movie>> searchMovies(String query) async {
    var url = Uri.https(_baseUrl, '/3/search/movie', {
      'language': _language,
      'query': query,
    });

    final response = await http.get(url, headers: _headers);
    final searchResponse = NowPlayingResponse.fromJson(response.body);
    return searchResponse.results;
  }

  Future<List<Actor>> getMovieCast(int movieId) async {
    var url = Uri.https(_baseUrl, '/3/movie/$movieId/credits', {
      'language': _language,
    });

    final response = await http.get(url, headers: _headers);
    final castResponse = CastResponse.fromJson(response.body);
    return castResponse.cast;
  }
}
