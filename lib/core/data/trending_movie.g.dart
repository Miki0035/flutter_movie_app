// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingMovie _$TrendingMovieFromJson(Map<String, dynamic> json) =>
    TrendingMovie(
      searchTerm: json['searchTerm'] as String,
      count: (json['count'] as num).toInt(),
      posterUrl: json['posterUrl'] as String,
      movieId: (json['movieId'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$TrendingMovieToJson(TrendingMovie instance) =>
    <String, dynamic>{
      'searchTerm': instance.searchTerm,
      'movieId': instance.movieId,
      'count': instance.count,
      'title': instance.title,
      'posterUrl': instance.posterUrl,
    };
