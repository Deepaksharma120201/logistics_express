import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/authentication/auth_controller.dart';
import 'package:logistics_express/src/authentication/auth_service.dart';
import 'package:logistics_express/src/common_widgets/form/custom_loader.dart';
import 'package:logistics_express/src/common_widgets/form/firebase_exceptions.dart';
import 'package:logistics_express/src/common_widgets/form/form_header.dart';
import 'package:logistics_express/src/common_widgets/form/form_text_field.dart';
import 'package:logistics_express/src/common_widgets/form/validators.dart';
import 'package:logistics_express/src/features/screens/forgot_password/forgot_password.dart';
import 'package:logistics_express/src/features/screens/sign_up/signup_screen.dart';
import 'package:logistics_express/src/features/screens/user_screen/user_home_screen.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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
                    const Expanded(
                      flex: 2,
                      child: FormHeader(
                        currentLogo: 'logo',
                        imageSize: 110,
                        text: 'Login to your account',
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
                                  validator: (val) => Validators.validateEmail(val!),
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
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text('Forgot Password?'),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _isLoading ? null : () async {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState?.validate() ?? false) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final email =
                                          authController.emailController.text;
                                      final password =
                                          authController.passwordController.text;
                                      try {
                                        String? response =
                                            await authService.loginWithEmail(
                                          email,
                                          password,
                                        );
                                        if (response == null) {
                                          if (context.mounted) {
                                            authController.clearAll();
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const UserHomeScreen(),
                                              ),
                                            );
                                          }
                                        } else {
                                          if (context.mounted) {
                                            showErrorSnackBar(context, response);
                                          }
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
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
                                  child: const Text('Login'),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Don\'t have an account?  ',
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
                                            builder: (context) => const SignupPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Sign up',
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
