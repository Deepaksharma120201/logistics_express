import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/models/agent_model.dart';
import 'package:logistics_express/src/services/auth_controller.dart';
import 'package:logistics_express/src/services/auth_service.dart';
import 'package:logistics_express/src/models/user_model.dart';
import 'package:logistics_express/src/services/authentication/user_services.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/custom_widgets/firebase_exceptions.dart';
import 'package:logistics_express/src/custom_widgets/form_header.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/user_dashboard_screen.dart';

class VerifyEmail extends ConsumerStatefulWidget {
  const VerifyEmail({super.key, required this.email, this.user, this.agent});

  final String email;
  final UserModel? user;
  final AgentModel? agent;
  @override
  ConsumerState<VerifyEmail> createState() {
    return _VerifyEmailState();
  }
}

class _VerifyEmailState extends ConsumerState<VerifyEmail> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    final authService = ref.watch(authServiceProvider);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            AbsorbPointer(
              absorbing: _isLoading,
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
                              'Verification link has been sent to ${widget.email}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 50),
                            TextButton(
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      if (await authService
                                              .checkEmailVerified() &&
                                          context.mounted) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        final userServices = UserServices();
                                        await userServices.createUser(widget
                                            .user!); //i add here to be resolved for delivery agent
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
                                      } else {
                                        showErrorSnackBar(
                                          context,
                                          "Email not verified yet!",
                                        );
                                      }
                                      setState(() {
                                        _isLoading = false;
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
            if (_isLoading)
              const Center(
                child: CustomLoader(),
              ),
          ],
        ),
      ),
    );
  }
}
