import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/images.dart';
import 'package:flutter_movie_app/core/api.dart';
import 'package:flutter_movie_app/core/data/movie.dart';
import 'package:flutter_movie_app/core/data/movie_detail_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final dio = DioClient().dio;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
  }

  Future<MovieDetailModel?> _fetchMovieDetails() async {
    try {
      final response = await dio.get('/movie/${widget.movieId}');

      final result = response.data;

      if (response.statusCode != 200) {
        throw Exception('No movie found');
      }

      final movieDetail = MovieDetailModel.fromJson(
        result as Map<String, dynamic>,
      );

      return movieDetail;
    } catch (e) {
      debugPrint('Error fetchMovieDetails: $e');
      rethrow;
    }
  }

  Future<bool> _openUrl(String url) async {
    try {
      final uri = Uri.parse(url);

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('Error opening movie home page: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: FutureBuilder(
        future: _fetchMovieDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: MColor.grey));
          }
          if (snapshot.data == null || snapshot.hasError) {
            return Center(
              child: Text(
                "Oops... couldn't find movie detail, please try again",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                ),
              ),
            );
          }

          final movie = snapshot.data;

          return SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: 500,
                  imageUrl: movie?.posterPath != null
                      ? 'https://image.tmdb.org/t/p/w500${movie!.posterPath}'
                      : 'https://placehold.co/600x400/1a1a1a/ffffff.png',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16.0),
                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        movie!.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: Theme.of(
                            context,
                          ).textTheme.titleLarge!.fontSize,
                        ),
                      ),

                      SizedBox(height: 8.0),

                      RichText(
                        text: TextSpan(
                          children: [
                            // Release year
                            TextSpan(
                              text: movie!.releaseDate,
                              style: TextStyle(color: Colors.white),
                            ),

                            WidgetSpan(child: SizedBox(width: 12.0)),

                            // Runtime
                            TextSpan(
                              text: '${movie!.runtime}m',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 18.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(width: 4.0),
                          Text(
                            '${(movie!.voteAverage / 2).roundToDouble()}/ 10',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.fontSize,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.0),

                      // overview
                      MHeadLine(title: 'Overview'),
                      SizedBox(height: 8.0),

                      Text(
                        movie!.overview,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.fontSize,
                        ),
                      ),

                      SizedBox(height: 16.0),

                      // budget and revenue
                      Row(
                        children: [
                          // Budget
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MHeadLine(title: 'Budget'),
                              SizedBox(height: 4.0),
                              Text(
                                '\$${((movie?.budget ?? 0) / 1_000_000).round()} million',
                                style: TextStyle(
                                  fontSize: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontSize,
                                  color: MColor.lightPink,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 24.0),

                          // Revenue
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MHeadLine(title: 'Revenue'),
                              SizedBox(height: 4.0),
                              Text(
                                '\$${((movie?.revenue ?? 0) / 1_000_000).round()} million',
                                style: TextStyle(
                                  fontSize: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontSize,
                                  color: MColor.lightPink,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 16.0),

                      //Production Countries
                      MHeadLine(title: 'Production Countries'),
                      SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            ...?movie?.productionCountries?.map(
                              (company) => TextSpan(
                                text: '${company.name} · ',
                                style: TextStyle(
                                  fontSize: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontSize,
                                  color: MColor.lightPink,
                                  fontWeight: FontWeight.w600,
                                  height: 1.55,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.0),

                      //Production Companies
                      MHeadLine(title: 'Production Companies'),
                      SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            ...?movie?.productionCompanies?.map(
                              (company) => TextSpan(
                                text: '${company.name} · ',
                                style: TextStyle(
                                  fontSize: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontSize,
                                  color: MColor.lightPink,
                                  fontWeight: FontWeight.w600,
                                  height: 1.85,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.0),

                      // Button
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.sizeOf(context).height * 0.1,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await _openUrl(movie.homepage);
                            if (!result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to load data'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Ink(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(MImage.highlight),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Visit Homepage',
                                  style: TextStyle(
                                    fontSize: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.fontSize,
                                    color: MColor.dark,
                                    fontWeight: FontWeight.w600,
                                    height: 1.55,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Icon(Icons.arrow_forward, color: MColor.dark),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Text(_movie!.releaseDate),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MHeadLine extends StatelessWidget {
  const MHeadLine({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: MColor.grey,
        fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
      ),
    );
  }
}
