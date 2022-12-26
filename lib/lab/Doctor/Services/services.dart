import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharmacystore/lab/Services/auth_services.dart';

class Services {
  final CollectionReference doctorReference =
      FirebaseFirestore.instance.collection('Doctors');
  final CollectionReference labReference =
      FirebaseFirestore.instance.collection('Labs');
  final CollectionReference testsReference =
      FirebaseFirestore.instance.collection('Tests');
  final CollectionReference appointmentsReference =
      FirebaseFirestore.instance.collection('Appointments');
  final CollectionReference allReference =
      FirebaseFirestore.instance.collection('All Appointments');
  final CollectionReference doctorAppointmentsRefrence =
      FirebaseFirestore.instance.collection('Doctor Appointments');

  final CollectionReference resultReference =
      FirebaseFirestore.instance.collection('Results');
  final CollectionReference chatReference =
      FirebaseFirestore.instance.collection('chat');

  //get Labs stream
  Stream<QuerySnapshot> getLabsList() {
    return labReference
        .where('Manager Id', isEqualTo: AuthServices().getUid())
        .snapshots();
  }

  //get doctor stream
  Stream<QuerySnapshot> getDoctorsList() {
    return doctorReference.snapshots();
  }

  Stream<QuerySnapshot> getPatientMessagedList(String docId) {
    return chatReference.doc(docId).collection('messages').snapshots();
  }

  //get tests stream
  Stream<QuerySnapshot> getTestsList(String labId) {
    return testsReference.doc(labId).collection('Patient Tests').snapshots();
  }

  //get tests stream
  Stream<QuerySnapshot> getAllAppointments() {
    return allReference
        .where('Lab Id', isEqualTo: AuthServices().getUid())
        .snapshots();
  }

  //get doctor appointments stream
  Stream<QuerySnapshot> getDoctorAppointments() {
    return doctorAppointmentsRefrence
        // .where('Lab Id', isEqualTo: AuthServices().getUid())
        .snapshots();
  }

  //add test to database
  Future addAppointmentToDatabase(
    String name,
    String fName,
    String age,
    String gender,
    String testType,
    String uid,
    String address,
    String doctor,
    String labName,
    String dateTime,
    String phoneNumber,
  ) async {
    return await appointmentsReference
        .doc(uid)
        .collection('Appointments')
        .doc()
        .set({
      'Uid': uid,
      'Name': name,
      'Father Name': fName,
      'Age': age,
      'Gender': gender,
      'Test Type': testType,
      'Address': address,
      'Lab Name': labName,
      'Doctor Name': doctor,
      'Date Time': dateTime,
      'Phone Number': phoneNumber,
      'Lab Id': AuthServices().getUid(),
    });
  }

  //add test to database
  Future addAllAppointmentsToDatabase(
    String name,
    String fName,
    String age,
    String gender,
    String testType,
    String uid,
    String address,
    String doctor,
    String labName,
    String dateTime,
    String phoneNumber,
    String doctorConsultation,
  ) async {
    return await allReference.doc().set({
      'Name': name,
      'Uid': uid,
      'Father Name': fName,
      'Age': age,
      'Gender': gender,
      'Test Type': testType,
      'Address': address,
      'Lab Name': labName,
      'Doctor Name': doctor,
      'Date Time': dateTime,
      'Patient Phone Number': phoneNumber,
      'Doctor Consultation': doctorConsultation,
      'Lab Id': AuthServices().getUid(),
    });
  }

  //delete appointments from fire store
  Future deleteTheAppointment(String labId, String uid, String testType) async {
    testsReference
        .doc(labId)
        .collection('Patient Tests')
        .where('User Id', isEqualTo: uid)
        .where('Test Type', isEqualTo: testType)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('Tests')
            .doc(labId)
            .collection('Patient Tests')
            .doc(element.id)
            .delete()
            .then((value) {
          print('Success!');
        });
      });
    });
  }

  Future addPhotoTStorage(File file) async {
    final storage = FirebaseStorage.instance;
    var snapshot = await storage.ref().child(file.path).putFile(file);
    String url = await snapshot.ref.getDownloadURL();
    print(url);
    return url;
  }

//add result to database
  Future addResultsToDatabase(
    String uid,
    String url,
    String labName,
    String testType,
    String docName,
    String docConsultation,
  ) async {
    return await resultReference.doc(uid).collection('Results').doc().set({
      'Result Url': url,
      'Test Type': testType,
      'Lab Name': labName,
      'Doctor Name': docName,
      'Doctor Consultation': docConsultation,
    });
  }

  Future deleteApp(String nodeId) {
    return allReference.doc(nodeId).delete();
  }

  Future deleteLab(String nodeId) {
    return labReference.doc(nodeId).delete();
  }

  //store Location in profile
  // Future storeLocation(List position, String uid) {
  //   return labReference.doc(uid).update({
  //     'Location': position,
  //   });
  // }

//get Locations
  Future<QuerySnapshot> getLabs() {
    return labReference.get();
  }

  Future<QuerySnapshot> getDoctors() {
    return doctorReference.get();
  }
}
