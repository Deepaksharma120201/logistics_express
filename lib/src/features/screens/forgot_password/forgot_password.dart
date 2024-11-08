import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/authentication/auth_controller.dart';
import 'package:logistics_express/src/authentication/auth_service.dart';
import 'package:logistics_express/src/common_widgets/form/firebase_exceptions.dart';
import 'package:logistics_express/src/common_widgets/form/form_header.dart';
import 'package:logistics_express/src/common_widgets/form/form_text_field.dart';
import 'package:logistics_express/src/common_widgets/form/validators.dart';
import 'package:logistics_express/src/features/screens/email_verification/verify_email_screen.dart';
import 'package:logistics_express/src/features/screens/reset_password/reset_password_screen.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    final authService = ref.watch(authServiceProvider);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              const Expanded(
                flex: 2,
                child: FormHeader(
                  currentLogo: 'logo',
                  imageSize: 100,
                  text: 'Forgot Password?',
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
                      )),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(30),
                            child: Text(
                              'Don\'t worry!! it happens, Please enter the Email address associated with your account',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 25),
                          FormTextField(
                            label: 'Email',
                            hintText: 'Enter Email',
                            validator: (val) => Validators.validateEmail(val!),
                            icon: Icon(Icons.email),
                            keyboardType: TextInputType.emailAddress,
                            controller: authController.emailController,
                          ),
                          const SizedBox(height: 35),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (context.mounted) {
                                  authController.clearAll();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VerifyEmail(
                                        nextScreen: () => ResetPassword(),
                                        message:
                                            'E-mail verified successfully!',
                                      ),
                                    ),
                                  );
                                } else {
                                  if (context.mounted) {
                                    showErrorSnackBar(
                                      context,
                                      'Account with this email does not exists.',
                                    );
                                  }
                                }
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
