import 'package:flutter/material.dart';
import 'package:logistics_express/Theme/theme.dart';
import 'package:logistics_express/customtextfield.dart';
import 'package:logistics_express/header.dart';
import 'package:logistics_express/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(
              flex: 2,
              child: Header(
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
                        CustomTextField(
                          hintText: 'Enter Email',
                          label: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: kColorScheme.primary,
                            size: 32,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          hintText: 'Enter Password',
                          label: 'Password',
                          icon: Icon(
                            Icons.password,
                            color: kColorScheme.primary,
                            size: 32,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {},
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
                              onTap: () => SignupPage,
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
