import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (movies.length < 3) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.55,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.55,
      child: Swiper(
        itemCount: movies.length,
        autoplay: true,
        onTap: (int i) {
          Navigator.pushNamed(
            context,
            "details",
            arguments: movies[i],
          );
        },
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.48,
        itemBuilder: (_, int index) {
          final movie = movies[index];
          movie.heroId = "swiper-${movie.id}";
          return Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
