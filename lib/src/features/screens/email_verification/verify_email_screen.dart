import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/authentication/auth_controller.dart';
import 'package:logistics_express/src/authentication/services/user_services.dart';
import 'package:logistics_express/src/common_widgets/form/custom_loader.dart';
import 'package:logistics_express/src/common_widgets/form/firebase_exceptions.dart';
import 'package:logistics_express/src/common_widgets/form/form_header.dart';
import 'package:logistics_express/src/features/screens/user_screen/user_home_screen.dart';
import '../../../authentication/auth_service.dart';
import '../../../authentication/models/user_model.dart';

class VerifyEmail extends ConsumerStatefulWidget {
  const VerifyEmail({super.key, required this.email, required this.user});

  final String email;
  final UserModel user;

  @override
  ConsumerState<VerifyEmail> createState() {
    return _VerifyEmailState();
  }
}

class _VerifyEmailState extends ConsumerState<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    final authService = ref.watch(authServiceProvider);
    bool isLoading = false;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: Column(
                children: [
                  const Expanded(
                    flex: 2,
                    child: FormHeader(
                      currentLogo: 'logo',
                      imageSize: 110,
                      text: 'Verifying... E-mail',
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: double.infinity,
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
                            Text(
                              'Verification link has been sent to $widget.email',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 50),
                            TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      if (await authService
                                              .checkEmailVerified() &&
                                          context.mounted) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final userServices = UserServices();
                                        await userServices
                                            .createUser(widget.user);
                                        authController.clearAll();
                                        if (context.mounted) {
                                          showSuccessSnackBar(
                                            context,
                                            'Account created successfully!',
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserHomeScreen(),
                                            ),
                                          );
                                        }
                                        authController.clearAll();
                                      } else {
                                        showErrorSnackBar(
                                          context,
                                          "Email not verified yet!",
                                        );
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading) // Show the loader if loading
              const Center(
                child: CustomLoader(),
              ),
          ],
        ),
      ),
    );
  }
}
