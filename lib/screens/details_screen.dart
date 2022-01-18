import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              const SizedBox(height: 16.0),
              _Overview(),
              const SizedBox(height: 16.0),
              _Overview(),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Movie Reparto.toEnglish()",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 16.0),
              CastingCards(),
              const SizedBox(height: 16.0),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      pinned: true, // so appbar never disappears
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Container(
          // width: double.infinity,
          child: Text("Movie Name"),
        ),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage("https://via.placeholder.com/300x500"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage("assets/no-image.jpg"),
              image: NetworkImage("https://via.placeholder.com/200x300"),
              height: 150.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "movie.title",
                style: textTheme.headline6,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "movie.originalTitle",
                style: textTheme.subtitle1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_outline_rounded, color: Colors.grey),
                  const SizedBox(width: 4.0),
                  Text(
                    "movie.voteAverage",
                    style: textTheme.caption,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultrices, sem in facilisis viverra, metus velit lacinia lectus, sit amet egestas elit massa vel dui. Cras quis vehicula urna. Vivamus sit amet dignissim nisl, dictum dignissim nisi.",
        textAlign: TextAlign.justify,
      ),
    );
  }
}
