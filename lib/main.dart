import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/screens/splash_screen/splash_screen.dart';
import 'package:logistics_express/src/theme/theme.dart';

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      home: SplashScreen(),
    ),
  );
}

