import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/color.dart';

class MSearchBar extends StatelessWidget {
  const MSearchBar({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onTap: onTap,
      leading: Icon(Icons.search, color: MColor.lightPink),
      padding: WidgetStateProperty.resolveWith((state) {
        return EdgeInsets.symmetric(horizontal: 18.0);
      }),
      hintText: 'Search through 300+ movies online',
      hintStyle: WidgetStateProperty.resolveWith((state) {
        return TextStyle(color: MColor.grey, fontWeight: FontWeight.w100);
      }),
      keyboardType: TextInputType.text,
      backgroundColor: WidgetStateProperty.resolveWith((state) {
        return MColor.lightDark;
      }),
    );
  }
}
