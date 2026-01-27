import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/common/widgets/search_bar.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/images.dart';
import 'package:flutter_movie_app/constants/size.dart';
import 'package:flutter_movie_app/core/api.dart';
import 'package:flutter_movie_app/core/data/movie.dart';
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

  void changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(Duration(milliseconds: 500), () {
      if (value.isNotEmpty) {
        _handleSearch(value);
      }
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

      setState(() {
        _movies = queriedMovies;
      });
    } catch (e) {
      debugPrint('Error handle search: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
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

class MBottomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final double paddingVertical;
  final double paddingHorizontal;
  final VoidCallback? onTap;

  const MBottomNavItem({
    super.key,
    required this.label,
    required this.icon,
    this.isActive = false,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 8.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        decoration: BoxDecoration(
          color: isActive ? MColor.lightPink : Colors.black,
          borderRadius: isActive
              ? BorderRadius.circular(50.0)
              : BorderRadius.circular(0.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon,
              color: isActive ? Colors.black : Colors.grey,
              size: 25.0,
            ),
            SizedBox(width: 4.0),
            // Label
            if (isActive)
              Text(
                label,
                style: TextStyle(
                  color: MColor.dark,
                  fontWeight: FontWeight.w800,
                  fontSize: MSize.medium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
