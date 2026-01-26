import 'package:flutter/material.dart';
import 'package:flutter_movie_app/common/widgets/search_bar.dart';
import 'package:flutter_movie_app/core/api.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final dio = DioClient().dio;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text('Search', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
