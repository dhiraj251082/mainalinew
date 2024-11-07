class UserCredentials {
  final String username;
  final String password;
  String? role; // Make role optional by using '?'
  String? userId; // Make userId optional by using '?'
  String? name; // Make name optional by using '?'
  String? email; // Make email optional by using '?'

  UserCredentials({
    required this.username,
    required this.password,
    this.role, // No longer required, can be null
    this.userId, // No longer required, can be null
    this.name, // No longer required, can be null
    this.email, // No longer required, can be null
  });

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      username: json['username'],
      password: json['password'],
      role: json['role'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'role': role,
      'userId': userId,
      'name': name,
      'email': email,
    };
  }
}
