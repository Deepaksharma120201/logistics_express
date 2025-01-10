class AgentModel {
  final String? id;
  final String password;
  final String email;

  const AgentModel({
    this.id,
    required this.password,
    required this.email,
  });

  toJson() {
    return {
      "Email": email,
      "Password": password,
    };
  }
}
