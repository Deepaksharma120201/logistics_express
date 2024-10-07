import 'package:flutter/material.dart';
import 'package:logistics_express/Theme/theme.dart';
import 'package:logistics_express/customtextfield.dart';
import 'package:logistics_express/header.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Header(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            // horizontal: 0,
                            vertical: 5,
                          ),
                        ),
                        CustomTextField(
                          hintText: 'Enter Name',
                          label: 'Full Name',
                          icon: Icon(
                            Icons.supervised_user_circle_sharp,
                            color: kColorScheme.primary,
                            size: 32,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          hintText: 'Enter Phone no.',
                          label: 'Phone Number',
                          icon: Icon(
                            Icons.phone,
                            color: kColorScheme.primary,
                            size: 32,
                          ),
                          keyboardType: TextInputType.phone,
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
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Verify E-mail',
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
                              child: Text(
                                'Login',
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
