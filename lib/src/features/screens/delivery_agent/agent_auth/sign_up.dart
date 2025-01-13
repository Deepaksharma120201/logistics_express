import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/features/screens/customer/user_auth/login_screen.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';
import 'package:logistics_express/src/custom_widgets/form_header.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/validators.dart';
import 'package:logistics_express/src/services/authentication/auth_service.dart';
import 'package:logistics_express/src/custom_widgets/firebase_exceptions.dart';
import '../../../../models/user_auth_model.dart';
import '../../customer/user_auth/verify_email_screen.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    final authService = ref.watch(authServiceProvider);
    final role = ref.watch(roleProvider);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    flex: 2,
                    child: FormHeader(
                      currentLogo: 'logo',
                      imageSize: 110,
                      text: 'Create your account',
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
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                              ),
                              const SizedBox(height: 15),
                              FormTextField(
                                hintText: 'Enter Email',
                                label: 'Email',
                                validator: (val) =>
                                    Validators.validateEmail(val!),
                                icon: Icon(Icons.email),
                                keyboardType: TextInputType.emailAddress,
                                controller: authController.emailController,
                              ),
                              const SizedBox(height: 15),
                              FormTextField(
                                hintText: 'Enter Password',
                                label: 'Password',
                                obscureText: _obscurePassword,
                                validator: (val) =>
                                    Validators.validatePassword(val!),
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
                                icon: Icon(
                                  Icons.lock_outline,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(height: 15),
                              FormTextField(
                                label: 'Confirm Password',
                                hintText: 'Confirm Password',
                                icon: Icon(
                                  Icons.fingerprint_outlined,
                                ),
                                validator: (val) =>
                                    Validators.validateConfirmPassword(
                                  val!,
                                  authController.passwordController.text,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () async {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState?.validate() ??
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
                                          final userAuthDetails = UserAuthModel(
                                            email: email,
                                            role: role!,
                                          );
                                          try {
                                            String? response = await authService
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
                                                      userAuthModel:
                                                          userAuthDetails,
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
                                child: const Text('Verify Email'),
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
