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
    super.dispose();
  }
}

// Provider for AuthController
final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController();
});
