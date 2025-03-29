import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logistics_express/src/custom_widgets/custom_dialog.dart';
import 'package:logistics_express/src/features/screens/home_screen.dart';
import 'package:logistics_express/src/services/authentication/auth_service.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';

class Settings extends StatelessWidget {
  final AuthService authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final String email = user?.email ?? 'No email found';

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      title: 'Are you sure?',
                                      message:
                                          'Do you want to delete your account permanently?',
                                      onConfirm: () async {
                                        authService.deleteAccount(context);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                          (route) => false,
                                        );
                                        showSuccessSnackBar(
                                          context,
                                          "Account deleted successfully",
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Delete Account',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => authService.signOut(context),
                          child: const Text(
                            'LOGOUT',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
