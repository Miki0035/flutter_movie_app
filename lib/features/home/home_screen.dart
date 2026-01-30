import 'package:appwrite/appwrite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/common/widgets/movie_card.dart';
import 'package:flutter_movie_app/common/widgets/search_bar.dart';
import 'package:flutter_movie_app/common/widgets/trending_movie_widget.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/images.dart';
import 'package:flutter_movie_app/constants/size.dart';
import 'package:flutter_movie_app/core/api.dart';
import 'package:flutter_movie_app/core/appwrite.dart';
import 'package:flutter_movie_app/core/data/movie.dart';
import 'package:flutter_movie_app/core/data/trending_movie.dart';
import 'package:flutter_movie_app/core/env/env.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = DioClient().dio;

  List<TrendingMovie>? trendingMovies;

  @override
  void initState() {
    super.initState();
    _getTrendingMovies();
  }

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

      // await _getTrendingMovies();

      return data.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      debugPrint('Exception home screen init: $e');
      rethrow;
    }
  }

  Future<void> _getTrendingMovies() async {
    try {
      final rows = await AppwriteService.instance.tables.listRows(
        databaseId: Env.appwriteDatabaseId,
        tableId: Env.appwriteTableId,
        queries: [Query.limit(5), Query.orderDesc("count")],
      );
      if (rows.total <= 0) {
        return;
      }

      final data = rows.rows
          .map((row) => TrendingMovie.fromJson(row.data))
          .toList();

      setState(() {
        trendingMovies = data;
      });

      return;
    } catch (e) {
      debugPrint('Exception get trending movies: $e');
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
                  child: MSearchBar(onTap: widget.onTap),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (trendingMovies != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trending Movies',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: MSize.large,
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            height: 180,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: trendingMovies!.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 4.0),
                              itemBuilder: (context, index) =>
                                  TrendingMovieWidget(
                                    trendingMovie: trendingMovies![index],
                                    index: index,
                                  ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),

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
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: MColor.grey,
                            ),
                          );
                        }

                        if (!asyncSnapshot.hasData) {
                          return Center(
                            child: Text(
                              'No movies found',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.fontSize,
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5.0,
                                crossAxisSpacing: 24.0,
                                childAspectRatio: 0.38,
                              ),
                        );
                      },
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
