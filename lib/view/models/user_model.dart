class Users {
  final String id;
  final String email;
  final String name;
  final String role;
  final bool isAllowed;
  final String status;
  final List<String> keywords;

  Users({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.isAllowed,
    required this.status,
    required this.keywords,
  });

  factory Users.fromJson(Map<String, dynamic> jsonObject) {
    return Users(
      id: jsonObject['id'] as String,
      name: jsonObject['full_name'] as String,
      role: jsonObject['role'] as String,
      isAllowed: jsonObject['is_allowed'] as bool,
      status: jsonObject['status'] as String,
      email: (jsonObject['email'] ?? "") as String,
      keywords: List<String>.from(jsonObject["keywords"].map((x) => x)),
    );
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = name;
    map['role'] = role;
    map['is_allowed'] = isAllowed;
    map['status'] = status;
    map['email'] = email;
    map['keywords'] = List<String>.from(keywords.map((x) => x));
    return map;
  }
}
