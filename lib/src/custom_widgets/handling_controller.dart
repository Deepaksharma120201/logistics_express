import 'package:flutter_riverpod/flutter_riverpod.dart';

// State notifier for custom date picker
class DatePickerStateNotifier extends StateNotifier<bool> {
  DatePickerStateNotifier() : super(false);

  void setDatePickerOpen(bool isOpen) {
    state = isOpen;
  }
}

// State notifier for custom dropdown
class DropdownStateNotifier extends StateNotifier<bool> {
  DropdownStateNotifier() : super(false);

  void setDropdownOpen(bool isOpen) {
    state = isOpen;
  }
}

// Riverpod providers
final datePickerStateProvider =
    StateNotifierProvider<DatePickerStateNotifier, bool>(
  (ref) => DatePickerStateNotifier(),
);

final dropdownStateProvider =
    StateNotifierProvider<DropdownStateNotifier, bool>(
  (ref) => DropdownStateNotifier(),
);
