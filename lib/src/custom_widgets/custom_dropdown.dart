import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 3),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            hint: Text('Select $label'),
            value: value,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            validator: validator,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
