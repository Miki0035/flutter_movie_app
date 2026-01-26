import 'package:flutter/material.dart';
import 'package:flutter_movie_app/app.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/themes/theme.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(theme: MTheme.appTheme, home: const App()));
}
