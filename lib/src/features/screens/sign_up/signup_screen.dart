import 'package:flutter/material.dart';
import 'package:logistics_express/src/common_widgets/form/form_header.dart';
import 'package:logistics_express/src/common_widgets/form/form_text_field.dart';
import 'package:logistics_express/src/common_widgets/form/validators.dart';
import 'package:logistics_express/src/features/screens/email_verification/verify_email_screen.dart';
import 'package:logistics_express/src/features/screens/login/login_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                        FormTextfield(
                          validator: (val) => Validators.validateName(val!),
                          hintText: 'Enter Name',
                          label: 'Full Name',
                          icon: Icon(Icons.person),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 15),
                        FormTextfield(
                          hintText: 'Enter Phone no.',
                          label: 'Phone Number',
                          validator: (val) => Validators.validatePhone(val!),
                          icon: Icon(Icons.phone),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 15),
                        FormTextfield(
                          hintText: 'Enter Email',
                          label: 'Email',
                          validator: (val) => Validators.validateEmail(val!),
                          icon: Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VerifyEmail(),
                                ),
                              );
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
                                  color: Colors.black87, fontSize: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
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
            )
          ],
        ),
      ),
    );
  }
}
