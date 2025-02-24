import 'package:flutter/material.dart';

class DatePicker {
  static Future<String> pickDate(BuildContext context) async {
    DateTime pickedDate = DateTime.now();
    pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ) ??
        DateTime.now();
        
    // Return the formatted date as a string
    return "${pickedDate.day.toString().padLeft(2, '0')}/"
        "${pickedDate.month.toString().padLeft(2, '0')}/"
        "${pickedDate.year}";
  }
}
