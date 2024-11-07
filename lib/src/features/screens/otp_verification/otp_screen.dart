import 'package:flutter/material.dart';
import 'package:logistics_express/src/common_widgets/form/form_header.dart';
import 'package:logistics_express/src/common_widgets/form/form_text_field.dart';
import 'package:logistics_express/src/features/screens/reset_password/reset_password_screen.dart';
import 'package:logistics_express/src/theme/theme.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
                text: 'Enter OTP',
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
                        Container(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            'An 6 digit code has been send to your Email Address',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 25),
                        FormTextfield(
                          hintText: 'Enter OTP',
                          label: 'OTP',
                          icon: Icon(
                            Icons.mobile_friendly,
                            color: kColorScheme.primary,
                            size: 32,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 35),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResetPassword(),
                              ),
                            );
                          },
                          child: const Text(
                            'verify',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
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
    );
  }
}
