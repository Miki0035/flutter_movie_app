import 'package:dio/dio.dart';
import 'package:flutter_movie_app/core/env/env.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.themoviedb.org/3",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Env.tmdbApiKey}',
        },
      ),
    );
  }
}
