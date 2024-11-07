import 'package:flutter/material.dart';
import 'package:logistics_express/src/common_widgets/form/form_header.dart';
import 'package:logistics_express/src/common_widgets/form/form_text_field.dart';
import 'package:logistics_express/src/common_widgets/form/validators.dart';
import 'package:logistics_express/src/features/screens/forgot_password/forgot_password.dart';
import 'package:logistics_express/src/features/screens/sign_up/signup_screen.dart';
import 'package:logistics_express/src/features/screens/user_screen/user_home_screen.dart';
import 'package:logistics_express/src/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                          padding: EdgeInsets.symmetric(
                            // horizontal: 0,
                            vertical: 5,
                          ),
                        ),
                        const SizedBox(height: 15),
                        FormTextfield(
                          hintText: 'Enter Email',
                          label: 'Email',
                          validator: (val) => Validators.validateEmail(val!),
                          icon: Icon(
                            Icons.email,
                            color: kColorScheme.primary,
                            size: 32,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),
                        FormTextfield(
                          hintText: 'Enter Password',
                          label: 'Password',
                          validator: (val) => Validators.validatePassword(val!),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.remove_red_eye_sharp),
                          ),
                          icon: Icon(
                            Icons.fingerprint_rounded,
                            color: kColorScheme.primary,
                            size: 32,
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
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserHomeScreen(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?  ',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 20),
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
                                    color: Colors.blue[900], fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
