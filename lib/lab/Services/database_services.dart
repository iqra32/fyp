import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharmacystore/lab/Services/auth_services.dart';
import 'package:pharmacystore/utils/enums.dart';
import 'package:pharmacystore/view/models/user_model.dart';

class DatabaseServices {
  final CollectionReference labReference =
      FirebaseFirestore.instance.collection('Labs');

  final CollectionReference testsReference =
      FirebaseFirestore.instance.collection('Tests');
  final CollectionReference doctorAppointmentsRefrence =
      FirebaseFirestore.instance.collection('Doctor Appointments');
  final CollectionReference appointmentsReference =
      FirebaseFirestore.instance.collection('Appointments');
  final CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference resultReference =
      FirebaseFirestore.instance.collection('Results');
  final CollectionReference doctorReference =
      FirebaseFirestore.instance.collection('Doctors');

  //get Labs stream
  Stream<QuerySnapshot> getLabsList() {
    return labReference.snapshots();
  }

  // get result stream
  Stream<QuerySnapshot> getResult(String uid) {
    return resultReference.doc(uid).collection('Results').snapshots();
  }

  //get Labs stream
  Stream<QuerySnapshot> getAppointmentsList(String uid) {
    return appointmentsReference
        .doc(uid)
        .collection('Appointments')
        .snapshots();
  }

  //get users
  Stream<DocumentSnapshot> getUser(String uid) {
    return userReference.doc(uid).snapshots();
  }

  //add user to database
  Future addUserToDatabase(
    String userName,
    String email,
    String password,
    String profileUrl,
    String uid,
    String cast,
    GeoPoint geoPoint,
  ) async {
    return await userReference.doc(uid).set(Users(
            id: uid,
            name: userName,
            role: cast,
            status: UserStatus.active,
            email: email,
            keywords: [],
            isAllowed: true,
            geopoint: geoPoint)
        .toJson());
  }

  //add test to database
  Future addTestToDatabase(
      String name,
      String fName,
      String age,
      String gender,
      String testType,
      String labId,
      String uid,
      String phoneNumber,
      String doctorConsultation,
      String appointTime) async {
    Random random = Random();
    int docUid = random.nextInt(1000000000);
    return await testsReference
        .doc(labId)
        .collection('Patient Tests')
        .doc(docUid.toString())
        .set({
      'Name': name,
      'Father Name': fName,
      'Age': age,
      'Doc Id': docUid.toString(),
      'Gender': gender,
      'Test Type': testType,
      'User Id': uid,
      'Phone Number': phoneNumber,
      'Doctor Consultation': doctorConsultation,
      'Appointment Time': appointTime,
    });
  }

  //add doctor appointment to database
  Future addAppointmentToDatabase(
      String name,
      String fName,
      String age,
      String gender,
      String docId,
      String uid,
      String phoneNumber,
      // String doctorConsultation,
      String appointTime) async {
    Random random = Random();
    int docUid = random.nextInt(1000000000);
    return await doctorAppointmentsRefrence.doc(docUid.toString()).set({
      'Name': name,
      'Father Name': fName,
      'Age': age,
      'Doc Id': docId,
      'Gender': gender,
      'User Id': uid,
      'Phone Number': phoneNumber,
      'Doctor Consultation': "Yes",
      'Appointment Time': appointTime,
    });
  }

  Future deleteTest(String labId, String docId) async {
    return await testsReference
        .doc(labId)
        .collection('Patient Tests')
        .doc(docId)
        .delete();
  }

  //delete specific appointment
  Future deleteAppointment(String nodeId, String uid) {
    return appointmentsReference
        .doc(uid)
        .collection('Appointments')
        .doc(nodeId)
        .delete();
  }

  Future addPhotoTStorage(File file) async {
    final storage = FirebaseStorage.instance;
    var snapshot = await storage.ref().child(file.path).putFile(file);
    String url = await snapshot.ref.getDownloadURL();
    print(url);
    return url;
  }

  // Future checkForCast() {
  //   return userReference.doc(AuthServices().getUid()).get().then((value) {
  //      return value.get('role');
  // }});

  Future addLabToDatabase(
    String name,
    String address,
    String doctor,
    String phoneNumber,
    List position,
  ) async {
    Random random = Random();
    int docUid = random.nextInt(100000);
    return await labReference.doc(docUid.toString()).set({
      'Lab Name': name,
      'Address': address,
      'Doctor': doctor,
      'Phone Number': phoneNumber,
      'Doc Id': docUid.toString(),
      'Manager Id': AuthServices().getUid(),
      'Position': position,
    });
  }

  Future addDoctorToDatabase(
    String clinicName,
    String clinicAddress,
    String docName,
    String phoneNumber,
    String docQualification,
    List position,
    String docid,
  ) async {
    Random random = Random();
    int docUid = random.nextInt(100000);
    return await doctorReference.doc(docUid.toString()).set({
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'docName': docName,
      'phoneNumber': phoneNumber,
      'docQualification': docQualification,
      'Doc Id': docUid.toString(),
      'Doctor Id': AuthServices().getUid(),
      'Position': position,
    });
  }

  //delete specific appointment
  Future deleteResult(String nodeId, String uid) {
    return resultReference.doc(uid).collection('Results').doc(nodeId).delete();
  }

  Future getMyLocation() {
    return userReference.doc(AuthServices().getUid()).get();
  }
}
