import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/authentication/auth_controller.dart';
import 'package:logistics_express/src/authentication/auth_service.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/custom_widgets/firebase_exceptions.dart';
import 'package:logistics_express/src/custom_widgets/form_header.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/validators.dart';
import 'package:logistics_express/src/features/screens/customer/user_auth/reset_password.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  validator: (val) =>
                                      Validators.validateEmail(val!),
                                  icon: Icon(FontAwesomeIcons.envelope),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: authController.emailController,
                                ),
                                const SizedBox(height: 35),
                                ElevatedButton(
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            final String email = authController
                                                .emailController.text
                                                .trim();
                                            String? response = await authService
                                                .resetPassword(email);
                                            if (response == null &&
                                                context.mounted) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResetPassword(
                                                    email: authController
                                                        .emailController.text,
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
                                            setState(() {
                                              _isLoading = false;
                                            });
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
              if (_isLoading)
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
