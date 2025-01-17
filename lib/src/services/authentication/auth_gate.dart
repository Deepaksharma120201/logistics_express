import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/features/screens/home_screen.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/user_dashboard_screen.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/agent_dashboard_screen.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/details_fillup.dart';
import 'package:logistics_express/src/services/authentication/auth_service.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => AuthGateState();
}

class AuthGateState extends ConsumerState<AuthGate> {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>?> _getUserRole(User? user) async {
    if (user != null) {
      try {
        return await _authService.getUserRole(user.uid, context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
        return {'error': e.toString()};
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Handle loading state for the auth stream
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;
          if (user == null) {
            // Navigate to HomeScreen when no user is logged in
            Future.microtask(() {
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              }
            });
            return const SizedBox.shrink();
          }

          // User is logged in, fetch their role
          return FutureBuilder<Map<String, dynamic>?>(
            future: _getUserRole(user),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (roleSnapshot.hasError) {
                return const Center(
                  child: Text('Failed to load role. Please try again later.'),
                );
              }

              final data = roleSnapshot.data;

              if (data == null || data.containsKey('error')) {
                // Navigate to HomeScreen if role data is null or contains an error
                Future.microtask(() {
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  }
                });
                return const SizedBox.shrink();
              }

              final role = data['role'];
              final profileComplete = data['isCompleted'] ?? false;

              // Navigate based on role and profile completion
              if (role == 'Delivery Agent') {
                return profileComplete
                    ? const AgentHomeScreen()
                    : const DetailsFillup();
              } else if (role == 'Customer') {
                return const UserHomeScreen();
              } else {
                return const Center(
                  child: Text('Unknown role. Please contact support.'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
