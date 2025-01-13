import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logistics_express/src/models/user_auth_model.dart';
import '../../models/user_model.dart';

class UserServices {
  final _fireStore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _fireStore.collection("users").add(user.toJson());
  }

  Future<void> createAuthUser(UserAuthModel user) async {
    await _fireStore.collection("user_auth").add(user.toJson());
  }
}
