import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 147, 25, 199),
);

var theme = ThemeData(
  useMaterial3: true,
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: kColorScheme.onPrimaryContainer,
  textTheme: ThemeData().textTheme.copyWith(
        bodyLarge: GoogleFonts.playpenSans(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: kColorScheme.onPrimaryContainer,
        ),
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primary,
      foregroundColor: kColorScheme.onPrimary,
    ),
  ),
);
