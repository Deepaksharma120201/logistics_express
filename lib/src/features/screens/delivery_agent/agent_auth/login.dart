import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/services/auth_controller.dart';
import 'package:logistics_express/src/custom_widgets/form_header.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/validators.dart';
import 'package:logistics_express/src/features/screens/customer/user_auth/forgot_password.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/details_fillup.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/sign_up.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    // final authService = ref.watch(authServiceProvider);

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
                      text: 'Login as a Delivery Agent',
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailsFillup(),
                                    ),
                                  );
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
                                          builder: (context) => const SignUp(),
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
            ],
          ),
        ),
      ),
    );
  }
}
