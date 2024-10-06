import 'package:flutter/material.dart';
import 'package:logistics_express/Theme/theme.dart';
import 'package:logistics_express/signup_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      home: const SignupPage(),
    ),
  );
}
