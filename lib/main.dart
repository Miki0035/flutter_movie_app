import 'package:flutter/material.dart';
import 'package:flutter_movie_app/app.dart';
import 'package:flutter_movie_app/core/appwrite.dart';
import 'package:flutter_movie_app/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppwriteService.instance.init();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MTheme.appTheme,
      home: const App(),
    ),
  );
}
