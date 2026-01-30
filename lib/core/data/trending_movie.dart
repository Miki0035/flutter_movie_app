import 'package:json_annotation/json_annotation.dart';
part 'trending_movie.g.dart';

@JsonSerializable()
class TrendingMovie {
  final String searchTerm;
  final int movieId;
  final int count;
  final String title;
  final String posterUrl;

  TrendingMovie({
    required this.searchTerm,
    required this.count,
    required this.posterUrl,
    required this.movieId,
    required this.title,
  });

  // connect generated class json
  factory TrendingMovie.fromJson(Map<String, dynamic> json) =>
      _$TrendingMovieFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingMovieToJson(this);
}
