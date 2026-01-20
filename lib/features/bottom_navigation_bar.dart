import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/images.dart';
import 'package:flutter_movie_app/constants/size.dart';
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

  // screens
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  void changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            SliverToBoxAdapter(child: _screens[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
      // bottomNavigationBar: NavigationBar(
      //   selectedIndex: _selectedIndex,
      //   onDestinationSelected: (value) {
      //     changeSelectedIndex(value);
      //   },
      //
      //   destinations: [
      //     // Home
      //     NavigationDestination(
      //       // icon: Image.asset(MImage.homeIcon),
      //       icon: Icon(Icons.home_filled, ),
      //
      //       label: 'Home',
      //     ),
      //     // Search
      //     NavigationDestination(
      //       icon: Image.asset(MImage.searchIcon),
      //       label: 'Search',
      //     ),
      //     // Saved
      //     NavigationDestination(
      //       icon: Image.asset(MImage.saveIcon),
      //       label: 'Save',
      //     ),
      //     // Profile
      //     NavigationDestination(
      //       icon: Image.asset(MImage.personIcon),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
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
          borderRadius:
              isActive
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
