import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/handling_controller.dart';

// Custom DatePicker with Riverpod state management
class DatePicker {
  static Future<String> pickDate(BuildContext context, WidgetRef ref) async {
    ref.read(datePickerStateProvider.notifier).setDatePickerOpen(true);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    ref.read(datePickerStateProvider.notifier).setDatePickerOpen(false);

    if (pickedDate == null) return '';

    // Return formatted date as a string
    return "${pickedDate.day.toString().padLeft(2, '0')}/"
        "${pickedDate.month.toString().padLeft(2, '0')}/"
        "${pickedDate.year}";
  }
}
