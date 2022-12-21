import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String email;
  final String name;
  final String role;
  final String status;
  GeoPoint geoPoint;

  Users({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.status,
    required this.geoPoint,
  });

  factory Users.fromJson(Map<String, dynamic> jsonObject) {
    return Users(
      id: jsonObject['id'] as String,
      name: jsonObject['full_name'] as String,
      role: jsonObject['role'] as String,
      status: jsonObject['status'] as String,
      email: (jsonObject['email'] ?? "") as String,
      geoPoint:
          (jsonObject['geopoint'] ?? const GeoPoint(0.0, 0.0)) as GeoPoint,
    );
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = name;
    map['role'] = role;
    map['status'] = status;
    map['geopoint'] = geoPoint;
    map['email'] = email;
    return map;
  }
}
