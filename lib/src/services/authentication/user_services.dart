import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class UserServices {
  final _fireStore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _fireStore.collection("users").add(user.toJson());
  }
}
