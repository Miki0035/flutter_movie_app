import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/constants/images.dart';
import 'package:flutter_movie_app/constants/size.dart';

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
          image: isActive
              ? DecorationImage(image: AssetImage(MImage.highlight))
              : null,
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
