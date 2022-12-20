import 'package:cloud_firestore/cloud_firestore.dart';

class FBCollections {
  static CollectionReference notifications =
      FirebaseFirestore.instance.collection("notifications");
  static CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  static CollectionReference medicines =
      FirebaseFirestore.instance.collection("medicines");
}
