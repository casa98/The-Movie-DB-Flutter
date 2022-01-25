import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Movies";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
        splashRadius: 20.0,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 20.0,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const Text("buildResults");
  }

  // Triggered each time query changes (what user types)
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          size: 128,
          color: Colors.black45,
        ),
      );
    }

    final moviesProvider = context.read<MoviesProvider>();

    return FutureBuilder<List<Movie>>(
      future: moviesProvider.searchMovie(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.movie_creation_outlined,
                  size: 128,
                  color: Colors.black45,
                ),
                SizedBox(height: 16.0),
                Text("No Movies found.", style: TextStyle(fontSize: 18.0)),
              ],
            ),
          );
        }

        final movies = snapshot.data!;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (_, index) =>
              _SearchMovieResponseItem(movie: movies[index]),
        );
      },
    );
  }
}

class _SearchMovieResponseItem extends StatelessWidget {
  const _SearchMovieResponseItem({Key? key, required this.movie})
      : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage("assets/no-image.jpg"),
        image: NetworkImage(movie.fullPosterImg),
        width: 50.0,
        fit: BoxFit.cover,
      ),
      title: Text(movie.title),
      subtitle: Row(
        children: [
          const Icon(
            Icons.star_outline_rounded,
            size: 18.0,
            color: Colors.black54,
          ),
          Text(" ${movie.voteAverage}"),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, "details", arguments: movie);
      },
    );
  }
}
