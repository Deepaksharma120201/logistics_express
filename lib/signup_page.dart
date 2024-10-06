import 'package:flutter/material.dart';
import 'package:logistics_express/customtextfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          const Expanded(
            flex: 2,
            child: SizedBox(
                child: Column(
                  children: [
                    Text('Sign Up', style: TextStyle(),),
                    Text('Into your account'),
                  ],
                )),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Customtextfield(
                      hintText: 'Name',
                      label: 'Enter Full Name',
                      icon: Icon(Icons.supervised_user_circle_sharp),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    const Customtextfield(
                      hintText: 'Enter Phone',
                      label: 'Phone Number',
                      icon: Icon(Icons.phone),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15),
                    const Customtextfield(
                      hintText: 'Email',
                      label: 'Enter Email',
                      icon: Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSecondary),
                      onPressed: () {},
                      child: const Text('Verify E-mail'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
