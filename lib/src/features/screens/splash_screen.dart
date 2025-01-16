import 'package:flutter/material.dart';
import 'dart:async';
import 'package:logistics_express/src/services/authentication/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and define the animation
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)); // Animation duration

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward(); // Start the animation

    // Navigate to home screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AuthGate()));
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          // Scale transition for the icon
          scale: _animation,
          child: Image.asset(
            'assets/images/main_logo.png', // logo in the assets folder
            width: 250, // Logo size
            height: 200,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
