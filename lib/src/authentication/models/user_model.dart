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

  toJson() {
    return {
      "Name": name,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
    };
  }
}
