import 'package:flutter/material.dart';
import 'package:flutter_movie_app/app.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:flutter_movie_app/themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(theme: MTheme.appTheme, home: const App()));
}
