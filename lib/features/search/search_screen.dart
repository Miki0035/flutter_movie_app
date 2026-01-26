import 'package:flutter/material.dart';
import 'package:flutter_movie_app/common/widgets/movie_card.dart';
import 'package:flutter_movie_app/common/widgets/search_bar.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/size.dart';
import 'package:flutter_movie_app/core/api.dart';
import 'package:flutter_movie_app/core/data/movie.dart';
import 'package:flutter_movie_app/features/home/home_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.movies, this.query = ''});
  final List<Movie> movies;
  final String query;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Search results for ',
                  style: TextStyle(color: Colors.white, fontSize: MSize.large),
                ),
                TextSpan(
                  text: query,
                  style: TextStyle(
                    color: MColor.lightPink,
                    fontSize: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.fontSize,
                  ),
                ),
              ],
            ),
          ),

          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: MovieCard(movie: movies[index]),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.44,
            ),
          ),
        ],
      ),
    );
  }
}
