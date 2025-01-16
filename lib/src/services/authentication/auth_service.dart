import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/firebase_exceptions.dart';
import 'package:logistics_express/src/features/screens/home_screen.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      // Send verification email
      await user?.sendEmailVerification();
      return null; // No error
    } on FirebaseAuthException catch (e) {
      return FirebaseExceptions.getErrorMessage(e);
    }
  }

  Future<String?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        try {
          final doc =
              await _firestore.collection('user_auth').doc(user.uid).get();
          final data = doc.data();
          if (data != null && data.containsKey('role')) {
            return data['role'];
          } else {
            return 'Role not found in Firestore document.';
          }
        } catch (e) {
          return e.toString();
        }
      } else {
        // Email is not verified, sign out the user and return a message
        await _firebaseAuth.signOut();
        return 'Please verify your email before logging in.';
      }
    } on FirebaseAuthException catch (e) {
      return FirebaseExceptions.getErrorMessage(e);
    }
  }

  // Check if the user's email is verified
  Future<bool> checkEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<String?> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      return 'Verification email sent!';
    } else if (user != null && user.emailVerified) {
      return 'Email already verified!';
    }
    return null;
  }

  // New reset password function
  Future<String?> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return FirebaseExceptions.getErrorMessage(e);
    }
  }

  Future<Map<String, dynamic>> getUserRole(String uid, context) async {
    try {
      final doc = await _firestore.collection('user_auth').doc(uid).get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data.containsKey('role')) {
          return {
            'role': data['role'],
            'isCompleted': data['isCompleted'] ?? false,
          };
        } else {
          throw Exception('Role not found in user_auth document.');
        }
      } else {
        throw Exception('User document does not exist.');
      }
    } catch (e) {
      showErrorSnackBar(context, e.toString());
      rethrow;
    }
  }

  // SignOut
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
        showSuccessSnackBar(context, 'Successfully Logout!');
      }
    } catch (e) {
      if (context.mounted) {
        showErrorSnackBar(context, e.toString());
      }
    }
  }
}

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final roleProvider = StateProvider<String?>((ref) => null);
