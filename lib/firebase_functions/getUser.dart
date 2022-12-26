import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacystore/view/models/user_model.dart';

Future<Users?> getUser() async {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  var user = await fs
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  Users users = Users.fromJson(user.data() as Map<String, dynamic>);
  return users;
}

Stream<DocumentSnapshot<Users>> getUserStream() {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  return fs
      .collection('users')
      .withConverter<Users>(
          fromFirestore: (doc, _) =>
              Users.fromJson(doc.data() as Map<String, dynamic>),
          toFirestore: (user, _) => user.toJson())
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}
