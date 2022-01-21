import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "747a68d2e18d087e667644e35b545555";
  final String _language = "en-US";

  List<Movie> onPlayingNowMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  getNowPlayingMovies() async {
    final response = await getJsonData("3/movie/now_playing");
    log(response);
    final onPlayingNowMovies = NowPlayingResponse.fromJson(response);
    this.onPlayingNowMovies = [...onPlayingNowMovies.movies];
    notifyListeners();
  }

  getPopularMovies() async {
    final response = await getJsonData("3/movie/popular", page: 1);
    log(response);
    final popularMovies = PopularResponse.fromJson(response);
    // It concatenates new movies to existing one (used when paging)
    this.popularMovies = [...this.popularMovies, ...popularMovies.movies];
  }

  Future<String> getJsonData(String endpoint, {int page = 1}) async {
    var url = Uri.https(
      _baseUrl,
      endpoint,
      {"language": _language, "api_key": _apiKey, "page": "$page"},
    );
    final response = await http.get(url);
    return response.body;
  }
}
