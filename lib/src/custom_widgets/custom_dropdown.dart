import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/handling_controller.dart';

class CustomDropdown extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
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
            onChanged: (newValue) {
              onChanged?.call(newValue);
              Future.delayed(const Duration(milliseconds: 100), () {
                ref.read(dropdownStateProvider.notifier).setDropdownOpen(false);
              });
            },
            validator: validator,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            onTap: () =>
                ref.read(dropdownStateProvider.notifier).setDropdownOpen(true),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
