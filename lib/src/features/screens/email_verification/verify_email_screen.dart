import 'package:flutter/material.dart';
import 'package:logistics_express/src/common_widgets/form/form_header.dart';
import 'package:logistics_express/src/features/screens/login/login_screen.dart';
import 'package:logistics_express/src/features/screens/user_screen/user_home_screen.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() {
    return _VerifyEmailState();
  }
}

class _VerifyEmailState extends State<VerifyEmail> {
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
                text: 'Verifying... Email',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      const Text(
                        'We have just sent an email verification link to your email. Please check your email and click on that link to verify your Email address.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'If not auto-redirected after verification, click on the Continue button.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserHomeScreen(),
                            ),
                          );
                        },
                        child: const Text('Continue'),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VerifyEmail(),
                            ),
                          );
                        },
                        child: const Text('Resend Email Link'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Back to login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
