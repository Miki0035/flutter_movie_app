import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/common/widgets/bottom_nav_item.dart';
import 'package:flutter_movie_app/common/widgets/search_bar.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/images.dart';
import 'package:flutter_movie_app/core/api.dart';
import 'package:flutter_movie_app/core/appwrite.dart';
import 'package:flutter_movie_app/core/data/movie.dart';
import 'package:flutter_movie_app/core/data/trending_movie.dart';
import 'package:flutter_movie_app/core/env/env.dart';
import 'package:flutter_movie_app/features/home/home_screen.dart';
import 'package:flutter_movie_app/features/profile/profile_screen.dart';
import 'package:flutter_movie_app/features/saved/saved_screen.dart';
import 'package:flutter_movie_app/features/search/search_screen.dart';

class MBottomNav extends StatefulWidget {
  const MBottomNav({super.key});

  @override
  State<MBottomNav> createState() => _MBottomNavState();
}

class _MBottomNavState extends State<MBottomNav> {
  final TextEditingController _controller = TextEditingController();
  final dio = DioClient().dio;
  int _selectedIndex = 0;
  List<Movie> _movies = [];
  Timer? _debounce;
  bool _isSearching = false;

  void changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(Duration(milliseconds: 500), () async {
      if (value.isEmpty) {
        setState(() {
          _movies = [];
          _isSearching = false;
        });
        return;
      }

      setState(() {
        _isSearching = true;
      });

      await _handleSearch(value);

      setState(() {
        _isSearching = false;
      });
    });
  }

  Future<void> _handleSearch(String value) async {
    try {
      if (value.isEmpty) {
        return;
      }
      debugPrint('value is $value');
      final response = await dio.get(
        '/search/movie',
        queryParameters: {"query": value},
      );

      //  change List<dynamic> to List<Map<String, dynamic>
      final data = (response.data['results'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      if (data.isEmpty) {
        setState(() {
          _movies = [];
        });
        return;
      }

      final queriedMovies = data.map((movie) => Movie.fromJson(movie)).toList();
      final firstQueriedMovie = queriedMovies[0];

      // query appwrite if movie exists in database and update count
      final result = await AppwriteService.instance.tables.listRows(
        databaseId: Env.appwriteDatabaseId,
        tableId: Env.appwriteTableId,
        queries: [Query.equal("searchTerm", value)],
      );

      if (result.rows.isNotEmpty) {
        // search Term exists
        // update database
        final existingMovie = result.rows[0];
        await AppwriteService.instance.tables.updateRow(
          databaseId: Env.appwriteDatabaseId,
          tableId: Env.appwriteTableId,
          rowId: existingMovie.$id,
          data: {"count": existingMovie.data["count"] + 1},
        );
        return;
      } else {
        // create new record for searchTerm
        final newRecord = TrendingMovie(
          searchTerm: value,
          count: 1,
          posterUrl:
              'https://image.tmdb.org/t/p/w500${firstQueriedMovie.posterPath}',
          movieId: firstQueriedMovie.id,
          title: firstQueriedMovie.title,
        );
        await AppwriteService.instance.tables.createRow(
          databaseId: Env.appwriteDatabaseId,
          tableId: Env.appwriteTableId,
          rowId: ID.unique(),
          data: newRecord.toJson(),
        );
      }

      setState(() {
        _movies = queriedMovies;
      });

      return;
    } catch (e) {
      debugPrint('Error handle search: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MImage.bg),
            fit: BoxFit.cover,
          ),
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
                    child: MSearchBar(
                      controller: _controller,
                      onTap: () {
                        changeSelectedIndex(1);
                      },
                      onChanged: _onSearchChanged,
                    ),
                  ),

                  _buildScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: MColor.lightDark,
          ),
          child: Row(
            children: [
              // Home
              Flexible(
                flex: _selectedIndex == 0 ? 2 : 1,
                child: MBottomNavItem(
                  isActive: _selectedIndex == 0,
                  icon: Icons.home,
                  label: 'Home',
                  onTap: () => changeSelectedIndex(0),
                ),
              ),
              // Search
              Flexible(
                flex: _selectedIndex == 1 ? 2 : 1,
                child: MBottomNavItem(
                  isActive: _selectedIndex == 1,
                  icon: Icons.search,
                  label: 'Search',
                  onTap: () => changeSelectedIndex(1),
                ),
              ),
              // Saved
              Flexible(
                flex: _selectedIndex == 2 ? 2 : 1,
                child: MBottomNavItem(
                  isActive: _selectedIndex == 2,
                  icon: Icons.bookmark_outline,
                  label: 'Saved',
                  onTap: () => changeSelectedIndex(2),
                ),
              ),
              // Profile
              Flexible(
                flex: _selectedIndex == 3 ? 2 : 1,
                child: MBottomNavItem(
                  isActive: _selectedIndex == 3,
                  icon: Icons.person,
                  label: 'Profile',
                  onTap: () => changeSelectedIndex(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen();

      case 1:
        return SearchScreen(movies: _movies, query: _controller.text);

      case 2:
        return SavedScreen();

      case 3:
        return ProfileScreen();

      default:
        return HomeScreen();
    }
  }
}
