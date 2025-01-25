class UserModel {
  final String? id;
  final String name;
  final String phoneNo;
  final String password;
  final String email;
  final String? gender;
  final String? profileUrl;

  const UserModel({
    this.id,
    required this.name,
    required this.phoneNo,
    required this.password,
    required this.email,
    this.gender = "",
    this.profileUrl = "",
  });

  // Convert the model to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "Name": name,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "Gender": gender,
      "ProfileUrl": profileUrl,
    };
  }

  // Create an instance from a Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return UserModel(
      id: id ?? map['id'], // Default to map['id'] if id is null
      name: map['Name'] ?? '',
      phoneNo: map['Phone'] ?? '',
      password: map['Password'] ?? '',
      email: map['Email'] ?? '',
      gender: map['Gender'] ?? '',
      profileUrl: map['ProfileUrl'] ?? '',
    );
  }
}
