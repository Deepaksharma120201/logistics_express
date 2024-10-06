import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 110,
          color: Colors.white,
        ),
        const Text(
          'Create your account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
