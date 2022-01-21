import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = context.watch<MoviesProvider>().onPlayingNowMovies;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Películas de Cine"),
        actions: [
          IconButton(
            onPressed: () {},
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
            CardSwiper(movies: nowPlayingMovies),
            const MovieSlider(),
          ],
        ),
      ),
    );
  }
}
