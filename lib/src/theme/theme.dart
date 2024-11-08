import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 147, 25, 199),
);

var theme = ThemeData(
  useMaterial3: true,
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: kColorScheme.onPrimaryContainer,

  // Enhanced text theme with Google Fonts
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: kColorScheme.onPrimaryContainer,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: kColorScheme.onPrimaryContainer,
    ),
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: kColorScheme.primary,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: kColorScheme.primary,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kColorScheme.onSecondaryContainer,
    ),
  ),

  // AppBar theme customization
  appBarTheme: AppBarTheme(
    backgroundColor: kColorScheme.primary,
    foregroundColor: kColorScheme.onPrimary,
    elevation: 0,
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kColorScheme.onPrimary,
    ),
  ),

  // Elevated Button customization
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primary,
      foregroundColor: kColorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      textStyle: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  iconTheme: IconThemeData(
    color: kColorScheme.primary,
    size: 32,
  ),

  // TextButton customization
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kColorScheme.secondary,
      textStyle: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),

  // Input Decoration theme for TextFormFields
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: kColorScheme.onSecondaryContainer, width: 1),
    ),
    labelStyle: GoogleFonts.roboto(
      color: kColorScheme.onSecondaryContainer,
      fontSize: 14,
    ),
    hintStyle: GoogleFonts.roboto(
      color: kColorScheme.onSecondaryContainer.withOpacity(0.7),
    ),
  ),

  // FloatingActionButton customization
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kColorScheme.primary,
    foregroundColor: kColorScheme.onPrimary,
    elevation: 4,
  ),

  // Card theme
  cardTheme: CardTheme(
    elevation: 3,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: kColorScheme.surface,
  ),
);
