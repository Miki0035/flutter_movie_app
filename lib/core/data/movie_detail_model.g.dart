// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailModel _$MovieDetailModelFromJson(Map<String, dynamic> json) =>
    MovieDetailModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String,
      video: json['video'] as bool,
      voteCount: (json['vote_count'] as num).toInt(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      budget: (json['budget'] as num).toInt(),
      homepage: json['homepage'] as String?,
      revenue: (json['revenue'] as num).toInt(),
      runtime: (json['runtime'] as num).toInt(),
    );

Map<String, dynamic> _$MovieDetailModelToJson(MovieDetailModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'adult': instance.adult,
      'video': instance.video,
      'budget': instance.budget,
      'homepage': instance.homepage,
      'production_companies': instance.productionCompanies,
      'production_countries': instance.productionCountries,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
    };

ProductionCompany _$ProductionCompanyFromJson(Map<String, dynamic> json) =>
    ProductionCompany(
      id: (json['id'] as num).toInt(),
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String,
    );

Map<String, dynamic> _$ProductionCompanyToJson(ProductionCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };

ProductionCountry _$ProductionCountryFromJson(Map<String, dynamic> json) =>
    ProductionCountry(
      iso: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProductionCountryToJson(ProductionCountry instance) =>
    <String, dynamic>{'iso_3166_1': instance.iso, 'name': instance.name};
