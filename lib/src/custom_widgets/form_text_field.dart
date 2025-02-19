import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.icon,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.obscureText,
    this.onChanged,
    this.readOnly,
    this.onTap,
  });

  final String label;
  final TextInputType? keyboardType;
  final String hintText;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onTap;
  final IconButton? suffixIcon;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool? obscureText;
  final Function(String)? onChanged;

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
            onTap: onTap,
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
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
