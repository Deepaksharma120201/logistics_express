class UserAuthModel {
  final String? id;
  final String role;
  final String email;
  final bool isCompleted;

  const UserAuthModel({
    this.id,
    required this.role,
    required this.email,
    this.isCompleted = false,
  });

  toJson() {
    return {
      "Email": email,
      "role": role,
      "isCompleted": isCompleted,
    };
  }
}
