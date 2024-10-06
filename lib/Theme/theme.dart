import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 111, 9, 151),
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodyLarge: const TextStyle(
      fontSize: 18, // Custom font size for bodyLarge
      fontWeight: FontWeight.w600, // Custom font weight
      color:  Color.fromARGB(255, 111, 9, 151),
    ),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(),
);
