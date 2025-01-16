class UserModel {
  final String? id;
  final String name;
  final String phoneNo;
  final String password;
  final String email;

  const UserModel({
    this.id,
    required this.name,
    required this.phoneNo,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "Name": name,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
    };
  }

  // Create an instance from a Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return UserModel(
      id: id,
      name: map['Name'] ?? '',
      phoneNo: map['Phone'] ?? '',
      password: map['Password'] ?? '',
      email: map['Email'] ?? '',
    );
  }
}
