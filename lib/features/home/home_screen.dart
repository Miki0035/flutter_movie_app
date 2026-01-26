import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/common/widgets/movie_card.dart';
import 'package:flutter_movie_app/common/widgets/search_bar.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/images.dart';
import 'package:flutter_movie_app/constants/size.dart';
import 'package:flutter_movie_app/core/api.dart';
import 'package:flutter_movie_app/core/data/movie.dart';
import 'package:flutter_movie_app/features/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = DioClient().dio;

  Future<List<Movie>> _init() async {
    try {
      final response = await dio.get('/discover/movie?sort_by=popularity.desc');

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch movies");
      }

      //  change List<dynamic> to List<Map<String, dynamic>
      final data = (response.data['results'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      return data.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      debugPrint('Exception home screen init: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest movies',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: MSize.large,
            ),
          ),
          FutureBuilder(
            future: _init(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: MColor.grey),
                );
              }

              if (!asyncSnapshot.hasData) {
                return Center(
                  child: Text(
                    'No movies found',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              }

              final movies = asyncSnapshot.data!;

              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(movie: movies[index]);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.44,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
