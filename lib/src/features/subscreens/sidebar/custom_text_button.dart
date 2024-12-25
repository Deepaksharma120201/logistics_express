import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: theme.colorScheme.onPrimary,
      ),
    );
  }
}
