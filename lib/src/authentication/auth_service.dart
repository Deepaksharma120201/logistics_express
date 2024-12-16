import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/firebase_exceptions.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
        return null;
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

  // String getCurrentUserEmail() {
  //   User? user = _firebaseAuth.currentUser;
  //   return user?.email ?? 'No email available';
  // }

  // New reset password function
  Future<String?> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return FirebaseExceptions.getErrorMessage(e);
    }
  }
}

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
