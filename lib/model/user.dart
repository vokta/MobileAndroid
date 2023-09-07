class User {
  final int id;
  final int roleId;
  final String email;
  final String name;

  User({
    required this.id,
    required this.roleId,
    required this.email,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      roleId: json['role_id'],
      email: json['email'],
      name: json['name'],
    );
  }
}