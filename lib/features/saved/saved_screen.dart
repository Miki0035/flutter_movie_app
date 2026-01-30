import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/images.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

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
            Icon(Icons.bookmark_outline, size: 32.0),
            SizedBox(height: 4.0),
            Text(
              'Saved',
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
