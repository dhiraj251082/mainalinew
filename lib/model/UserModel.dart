class UserModel {
  final String? name;
  final String? email;
  final String? role;
  final String? userId;

  UserModel({
    this.name,
    this.email,
    this.role,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'user_id': userId,
    };
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, role: $role, userId: $userId}';
  }
}
