import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/data/trending_movie.dart';

class TrendingMovieWidget extends StatelessWidget {
  const TrendingMovieWidget({
    super.key,
    required this.trendingMovie,
    required this.index,
  });

  final int index;
  final TrendingMovie? trendingMovie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          width: 140,
          height: 160,
          imageUrl: trendingMovie!.posterUrl,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
        Positioned(
          bottom: -15,
          left: 2,
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: Theme.of(context).textTheme.displayLarge!.fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
