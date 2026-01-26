// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  adult: json['adult'] as bool,
  backdropPath: json['backdrop_path'] as String?,
  genreIds: (json['genre_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  overview: json['overview'] as String,
  posterPath: json['poster_path'] as String?,
  releaseDate: json['release_date'] as String,
  video: json['video'] as bool,
  voteCount: (json['vote_count'] as num).toInt(),
  voteAverage: (json['vote_average'] as num).toDouble(),
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'title': instance.title,
  'id': instance.id,
  'adult': instance.adult,
  'video': instance.video,
  'backdrop_path': instance.backdropPath,
  'genre_ids': instance.genreIds,
  'overview': instance.overview,
  'poster_path': instance.posterPath,
  'release_date': instance.releaseDate,
  'vote_count': instance.voteCount,
  'vote_average': instance.voteAverage,
};
