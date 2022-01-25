import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';

import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_movie_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "747a68d2e18d087e667644e35b545555";
  final String _language = "en-US";

  List<Movie> onPlayingNowMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );
  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  getNowPlayingMovies() async {
    final response = await getJsonData("3/movie/now_playing");
    final onPlayingNowMovies = NowPlayingResponse.fromJson(response);
    this.onPlayingNowMovies = [...onPlayingNowMovies.movies];
    notifyListeners();
  }

  getPopularMovies() async {
    final response = await getJsonData("3/movie/popular", page: ++_popularPage);
    final popularMovies = PopularResponse.fromJson(response);
    // It concatenates new movies to existing one (used when paging)
    this.popularMovies = [...this.popularMovies, ...popularMovies.movies];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    final response = await getJsonData("3/movie/$movieId/credits");
    final creditsResponse = CreditsResponse.fromJson(response);
    return creditsResponse.cast;
  }

  Future<String> getJsonData(String endpoint, {int page = 1}) async {
    final url = Uri.https(
      _baseUrl,
      endpoint,
      {"language": _language, "api_key": _apiKey, "page": "$page"},
    );
    final response = await http.get(url);
    return response.body;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, "3/search/movie", {
      "language": _language,
      "api_key": _apiKey,
      "page": "1",
      "query": query,
    });

    final response = await http.get(url);
    final searchResponse = SearchMovieResponse.fromJson(response.body);
    return searchResponse.movies;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      log("Query to search: $value");
      final response = await searchMovie(value);
      _suggestionStreamController.add(response);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 201))
        .then((_) => timer.cancel());
  }
}
