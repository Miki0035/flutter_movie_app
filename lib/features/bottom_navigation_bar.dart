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
  int _selectedIndex = 0;

  void changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.symmetric(horizontal: 12.0),
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
    // return Scaffold(
    //   extendBody: true,
    //   body: Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage(MImage.bg),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: CustomScrollView(
    //       slivers: [
    //         SliverPadding(
    //           padding: const EdgeInsets.symmetric(vertical: 16.0),
    //           sliver: SliverAppBar(
    //             backgroundColor: Colors.transparent,
    //             centerTitle: true,
    //             title: Image.asset(MImage.logoIcon),
    //             expandedHeight: 100.0,
    //           ),
    //         ),
    //         // screens
    //         SliverToBoxAdapter(
    //           child: Column(
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.symmetric(vertical: 18.0),
    //                 child: MSearchBar(
    //                   controller: _controller,
    //                   onTap: () {
    //                     changeSelectedIndex(1);
    //                   },
    //                   onChanged: _onSearchChanged,
    //                 ),
    //               ),
    //
    //               _buildScreen(),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
  }

  Widget _buildScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(
          onTap: () {
            changeSelectedIndex(1);
          },
        );

      case 1:
        return SearchScreen();

      case 2:
        return SavedScreen();

      case 3:
        return ProfileScreen();

      default:
        return HomeScreen(
          onTap: () {
            changeSelectedIndex(1);
          },
        );
    }
  }
}
