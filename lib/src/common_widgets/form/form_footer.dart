import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/screens/reset_password/reset_password_screen.dart';

class FormFooter extends StatelessWidget {
  const FormFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetPassword(),
          ),
        );
      },
      child: const Text(
        'verify',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}