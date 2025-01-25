import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
  User? user = FirebaseAuth.instance.currentUser;

  // save files links to firestore
  Future<void> saveUploadedFilesData(Map<String, String> data) async {
    return FirebaseFirestore.instance
        .collection("user-files")
        .doc(user!.uid)
        .collection("uploads")
        .doc()
        .set(data);
  }

  // read all uploaded files
  Stream<QuerySnapshot> readUploadedFiles() {
    return FirebaseFirestore.instance
        .collection("user-files")
        .doc(user!.uid)
        .collection("uploads")
        .snapshots();
  }
}
