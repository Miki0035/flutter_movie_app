import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/common/widgets/movie_card.dart';
import 'package:flutter_movie_app/common/widgets/search_bar.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/images.dart';
import 'package:flutter_movie_app/constants/size.dart';
import 'package:flutter_movie_app/core/api.dart';
import 'package:flutter_movie_app/core/appwrite.dart';
import 'package:flutter_movie_app/core/data/movie.dart';
import 'package:flutter_movie_app/core/data/trending_movie.dart';
import 'package:flutter_movie_app/core/env/env.dart';
import 'package:flutter_movie_app/features/home/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final dio = DioClient().dio;
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  List<Movie> _movies = [];

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(Duration(milliseconds: 500), () async {
      if (value.isEmpty) {
        setState(() {
          _movies = [];
        });
        return;
      }
      await _handleSearch(value);
    });
  }

  Future<void> _handleSearch(String value) async {
    try {
      if (value.isEmpty) {
        return;
      }
      debugPrint('value is $value');
      final response = await dio.get(
        '/search/movie',
        queryParameters: {"query": value},
      );

      //  change List<dynamic> to List<Map<String, dynamic>
      final data = (response.data['results'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      if (data.isEmpty) {
        setState(() {
          _movies = [];
        });
        return;
      }

      final queriedMovies = data.map((movie) => Movie.fromJson(movie)).toList();
      final firstQueriedMovie = queriedMovies[0];

      // query appwrite if movie exists in database and update count
      final result = await AppwriteService.instance.tables.listRows(
        databaseId: Env.appwriteDatabaseId,
        tableId: Env.appwriteTableId,
        queries: [Query.equal("searchTerm", value)],
      );

      if (result.rows.isNotEmpty) {
        // search Term exists
        // update database
        final existingMovie = result.rows[0];
        await AppwriteService.instance.tables.updateRow(
          databaseId: Env.appwriteDatabaseId,
          tableId: Env.appwriteTableId,
          rowId: existingMovie.$id,
          data: {"count": existingMovie.data["count"] + 1},
        );
      } else {
        // create new record for searchTerm
        final newRecord = TrendingMovie(
          searchTerm: value,
          count: 1,
          posterUrl:
              'https://image.tmdb.org/t/p/w500${firstQueriedMovie.posterPath}',
          movieId: firstQueriedMovie.id,
          title: firstQueriedMovie.title,
        );
        await AppwriteService.instance.tables.createRow(
          databaseId: Env.appwriteDatabaseId,
          tableId: Env.appwriteTableId,
          rowId: ID.unique(),
          data: newRecord.toJson(),
        );
      }

      setState(() {
        _movies = queriedMovies;
      });

      return;
    } catch (e) {
      debugPrint('Error handle search: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(MImage.bg), fit: BoxFit.cover),
      ),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            sliver: SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Image.asset(MImage.logoIcon),
              expandedHeight: 100.0,
            ),
          ),
          // screens
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.0),
                  child: MSearchBar(
                    controller: _controller,
                    onChanged: _onSearchChanged,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Search results for ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.fontSize,
                            ),
                          ),
                          TextSpan(
                            text: _controller.text,
                            style: TextStyle(
                              color: MColor.lightPink,
                              fontSize: Theme.of(
                                context,
                              ).textTheme.titleLarge!.fontSize,
                            ),
                          ),
                        ],
                      ),
                    ),

                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: _movies[index]);
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
