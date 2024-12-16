import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/authentication/auth_controller.dart';
import 'package:logistics_express/src/authentication/auth_service.dart';
import 'package:logistics_express/src/authentication/models/user_model.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/custom_widgets/firebase_exceptions.dart';
import 'package:logistics_express/src/custom_widgets/form_header.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/validators.dart';
import 'package:logistics_express/src/features/screens/customer/user_auth/login_screen.dart';
import 'package:logistics_express/src/features/screens/customer/user_auth/verify_email_screen.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    final authService = ref.watch(authServiceProvider);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              AbsorbPointer(
                absorbing: _isLoading,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FormHeader(
                        text: 'Create Your Account',
                        currentLogo: "logo",
                        imageSize: 110,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FormTextField(
                                  validator: (val) =>
                                      Validators.validateName(val!),
                                  hintText: 'Enter Name',
                                  label: 'Full Name',
                                  icon: const Icon(Icons.person),
                                  keyboardType: TextInputType.text,
                                  controller: authController.nameController,
                                ),
                                const SizedBox(height: 15),
                                FormTextField(
                                  hintText: 'Enter Phone no.',
                                  label: 'Phone Number',
                                  validator: (val) =>
                                      Validators.validatePhone(val!),
                                  icon: const Icon(Icons.phone),
                                  keyboardType: TextInputType.phone,
                                  controller: authController.phoneController,
                                ),
                                const SizedBox(height: 15),
                                FormTextField(
                                  hintText: 'Enter Email',
                                  label: 'Email',
                                  validator: (val) =>
                                      Validators.validateEmail(val!),
                                  icon: const Icon(Icons.email),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: authController.emailController,
                                ),
                                const SizedBox(height: 15),
                                FormTextField(
                                  hintText: 'Enter Password',
                                  validator: (val) =>
                                      Validators.validatePassword(val!),
                                  label: 'Password',
                                  obscureText: _obscurePassword,
                                  icon: const Icon(Icons.lock),
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: authController.passwordController,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                FormTextField(
                                  hintText: 'Confirm Password',
                                  label: 'Confirm Password',
                                  validator: (val) =>
                                      Validators.validateConfirmPassword(
                                    val,
                                    authController.passwordController.text,
                                  ),
                                  icon: const Icon(Icons.fingerprint_outlined),
                                  keyboardType: TextInputType.visiblePassword,
                                  controller:
                                      authController.confirmPasswordController,
                                ),
                                const SizedBox(height: 25),
                                ElevatedButton(
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          FocusScope.of(context).unfocus();
                                          if (formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            final email = authController
                                                .emailController.text
                                                .trim();
                                            final password = authController
                                                .passwordController.text
                                                .trim();
                                            final name = authController
                                                .nameController.text
                                                .trim();
                                            final phone = authController
                                                .phoneController.text
                                                .trim();
                                            final userDetails = UserModel(
                                                name: name,
                                                phoneNo: phone,
                                                password: password,
                                                email: email);
                                            try {
                                              String? response =
                                                  await authService
                                                      .signUpWithEmail(
                                                email,
                                                password,
                                              );
                                              if (response == null) {
                                                if (context.mounted) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          VerifyEmail(
                                                        email: email,
                                                        user: userDetails,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              } else {
                                                if (context.mounted) {
                                                  showErrorSnackBar(
                                                      context, response);
                                                }
                                              }
                                            } catch (e) {
                                              if (context.mounted) {
                                                // Check if the context is still mounted
                                                showErrorSnackBar(
                                                  context,
                                                  'An error occurred: $e',
                                                );
                                              }
                                            } finally {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            }
                                          }
                                        },
                                  child: const Text('Verify E-mail'),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account?  ',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_isLoading) // Show the loader if loading
                const Center(
                  child: CustomLoader(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
