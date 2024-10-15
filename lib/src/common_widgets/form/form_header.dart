import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({
    super.key,
    this.text,
    required this.currentLogo,
    this.imageSize,
  });
  final String? text;
  final String? currentLogo;
  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/$currentLogo.png",
          width: imageSize,
          color: Colors.white,
        ),
        if (text != null) //only display text if available
          Text(
            text!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          )
        else
          const SizedBox.shrink(), //empty Widget if text is null
      ],
    );
  }
}
