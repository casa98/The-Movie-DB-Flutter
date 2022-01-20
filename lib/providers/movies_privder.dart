import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "747a68d2e18d087e667644e35b545555";
  final String _language = "en-US";

  MoviesProvider() {
    log("movies privder initialized");
    getNowPlayingMovies();
  }

  getNowPlayingMovies() async {
    log("getNowPlayingMovies");
    var url = Uri.https(
      _baseUrl,
      "3/movie/now_playing",
      {"language": _language, "api_key": _apiKey, "page": "1"},
    );
    final response = await http.get(url);
    final nowPlayingMovies = NowPlayingResponse.fromJson(response.body);
    log(nowPlayingMovies.movies.length.toString());
  }
}
