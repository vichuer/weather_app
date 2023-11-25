import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
      fontFamily: GoogleFonts.roboto().fontFamily,
      primarySwatch: Colors.green,
      appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0));
}

class AppColors {
  static Color grey60 = const Color.fromARGB(138, 83, 83, 83);
  static Color grad1 = const Color(0xff391A49);
  static Color grad2 = const Color(0xff301D5C);
  static Color grad3 = const Color(0xff262171);
  static Color grad4 = const Color(0xff301D5C);
}
