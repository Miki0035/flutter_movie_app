import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetailModel {
  final String title;
  final int id;
  final bool adult;
  final bool video;

  final int budget;
  final String? homepage;

  @JsonKey(name: 'production_companies')
  final List<ProductionCompany>? productionCompanies;

  @JsonKey(name: 'production_countries')
  final List<ProductionCountry>? productionCountries;

  final int revenue;

  final int runtime;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.adult,
    required this.backdropPath,
    this.genreIds,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.video,
    required this.voteCount,
    required this.voteAverage,
    this.productionCompanies,
    this.productionCountries,
    required this.budget,
    this.homepage,
    required this.revenue,
    required this.runtime,
  });

  // connect generated class json
  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);
}

@JsonSerializable()
class ProductionCompany {
  final int id;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String originCountry;

  const ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  // connect generated class json
  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

@JsonSerializable()
class ProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;

  const ProductionCountry({required this.iso, required this.name});
  // connect generated class json
  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}
