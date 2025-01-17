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

  Map<String, dynamic> toMap() {
    return {
      "Email": email,
      "role": role,
      "isCompleted": isCompleted,
    };
  }

  factory UserAuthModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return UserAuthModel(
      id: id,
      role: map['role'] ?? '',
      email: map['Email'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
