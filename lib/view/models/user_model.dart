class Users {
  final String id;
  final String email;
  final String name;
  final String role;
  final String status;

  Users({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.status,
  });

  factory Users.fromJson(Map<String, dynamic> jsonObject) {
    return Users(
      id: jsonObject['id'] as String,
      name: jsonObject['full_name'] as String,
      role: jsonObject['role'] as String,
      status: jsonObject['status'] as String,
      email: (jsonObject['email'] ?? "") as String,
    );
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = name;
    map['role'] = role;
    map['status'] = status;
    map['email'] = email;
    return map;
  }
}
