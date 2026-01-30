import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/images.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(MImage.bg), fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, size: 32.0),
            SizedBox(height: 4.0),
            Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
