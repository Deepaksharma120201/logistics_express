import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/common_widgets/form/firebase_exceptions.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUpWithEmail(
      String name, String email, String phoneNo, String password) async {
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
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
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

  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  String getCurrentUserEmail() {
    User? user = _firebaseAuth.currentUser;
    return user?.email ?? 'No email available';
  }
}

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
