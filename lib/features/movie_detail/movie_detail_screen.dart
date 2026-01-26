import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/data/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Center(
        child: Column(
          children: [
            Text(movie.overview, style: TextStyle(color: Colors.white)),
            Text(movie.releaseDate),
          ],
        ),
      ),
    );
  }
}
