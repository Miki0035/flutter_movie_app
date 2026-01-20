import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';
class MTheme {
  MTheme._();

  static ThemeData appTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.dmSansTextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent
    )
    // navigationBarTheme: NavigationBarThemeData(
    //   labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    //   labelPadding: EdgeInsets.all(8.0),
    //   indicatorColor: MColor.lightPink,
    //   indicatorShape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(16.0)
    //   ),
    //   iconTheme: WidgetStateProperty.resolveWith((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return IconThemeData(color: Colors.white,fill: 1.0 );
    //     }
    //   }),
    //   labelTextStyle: WidgetStateProperty.resolveWith((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return TextStyle(
    //         fontWeight: FontWeight.w800,
    //       );
    //     }
    //     return null;
    //   })
    // ),
  );
}
