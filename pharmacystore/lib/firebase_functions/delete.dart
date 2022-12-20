import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> deleteUser() {
  return users
      .doc('ABC123')
      .delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user: $error"));
}
