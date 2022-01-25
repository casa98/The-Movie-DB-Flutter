import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = context.watch<MoviesProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Now Playing Movies"),
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: MovieSearchDelegate(),
            ),
            icon: const Icon(Icons.search),
            splashRadius: 22.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardSwiper(movies: moviesProvider.onPlayingNowMovies),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              onNextpage: () {
                moviesProvider.getPopularMovies();
              },
            ),
          ],
        ),
      ),
    );
  }
}
