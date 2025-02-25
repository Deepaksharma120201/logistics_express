import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AuthController to manage input fields
class AuthController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController drivingLicenceController =
      TextEditingController();
  final TextEditingController vehicleRcController = TextEditingController();
  final TextEditingController sourceAddressController = TextEditingController();
  final TextEditingController destinationAddressController =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  // Clear all controllers
  void clearAll() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    aadharController.clear();
    dobController.clear();
    drivingLicenceController.clear();
    vehicleRcController.clear();
    sourceAddressController.clear();
    destinationAddressController.clear();
    weightController.clear();
    volumeController.clear();
    startDateController.clear();
    endDateController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    aadharController.dispose();
    dobController.dispose();
    drivingLicenceController.dispose();
    vehicleRcController.dispose();
    sourceAddressController.dispose();
    destinationAddressController.dispose();
    weightController.dispose();
    volumeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }
}

// Provider for AuthController
final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController();
});
