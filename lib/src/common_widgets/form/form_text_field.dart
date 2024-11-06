import 'package:flutter/material.dart';

class FormTextfield extends StatelessWidget {
  const FormTextfield({
    super.key,
    required this.label,
    required this.hintText,
    this.icon,
    required this.keyboardType,
    this.suffixIcon,
    this.validator,
    this.controller,
  });

  final String label;
  final TextInputType keyboardType;
  final String hintText;
  final Icon? icon;
  final IconButton? suffixIcon;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: icon,
          ),
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 22),
              labelText: label,
              hintText: hintText,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
