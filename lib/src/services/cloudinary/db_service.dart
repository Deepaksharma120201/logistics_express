import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update agent's profileUrl
  Future<void> updateImageUrl(String url) async {
    return _firestore.collection("agents").doc(user!.uid).update({
      "profileUrl": url,
    }).catchError((error) {});
  }
}
