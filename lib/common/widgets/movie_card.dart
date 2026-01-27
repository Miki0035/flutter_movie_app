import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/data/movie.dart';
import 'package:flutter_movie_app/features/movie_detail/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movieId: movie.id),
          ),
        );
      },
      child: Container(
        width: 500,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // movie image
            CachedNetworkImage(
              height: 180,
              imageUrl: movie.posterPath != null
                  ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                  : 'https://placehold.co/600x400/1a1a1a/ffffff.png',
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              fit: BoxFit.contain,
            ),

            // movie title
            Text(
              movie.title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: 8.0),

            // rating
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 4.0),
                Text(
                  '${(movie.voteAverage / 2).roundToDouble()}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 4.0),

            // genre
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Action'),
                  WidgetSpan(child: SizedBox(width: 12.0, child: Text('.'))),
                  TextSpan(text: 'Movie'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
