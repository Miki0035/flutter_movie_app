import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String title;
  final int id;
  final bool adult;
  final bool video;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.video,
    required this.voteCount,
    required this.voteAverage,
  });

  // connect generated class json
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
