import 'package:flutter/material.dart';
import 'package:logistics_express/src/common_widgets/form/form_header.dart';
import 'package:logistics_express/src/common_widgets/form/form_text_field.dart';
import 'package:logistics_express/src/common_widgets/form/validators.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                text: 'Reset Password',
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
                        const SizedBox(height: 25),
                        FormTextfield(
                          hintText: 'New Password',
                          label: 'New Password',
                          validator: Validators.validatePassword,
                          icon: Icon(Icons.lock_outlined),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 15),
                        FormTextfield(
                          hintText: 'Confirm Password',
                          label: 'Confirm Password',
                          // validator: Validators.validateConfirmPassword(value, password),
                          icon: Icon(Icons.fingerprint_outlined),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 35),
                        ElevatedButton(
                          onPressed: () {},
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
    );
  }
}
