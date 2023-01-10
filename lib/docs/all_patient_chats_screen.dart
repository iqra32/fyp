import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../lab/Doctor/Services/services.dart';
import 'chat_screen.dart';

class AllPatientMessagedScreen extends StatefulWidget {
  const AllPatientMessagedScreen({Key? key}) : super(key: key);

  @override
  State<AllPatientMessagedScreen> createState() =>
      _AllPatientMessagedScreenState();
}

class _AllPatientMessagedScreenState extends State<AllPatientMessagedScreen> {
  var user = FirebaseAuth.instance.currentUser;
  Services ser = Services();
  List allPatients = [];
  List<String> patientIds = [];

  @override
  void initState() {
    getAllPatientIds(user!.uid);
    super.initState();
  }

  getAllPatientIds(String docId) async {
    QuerySnapshot<Map<String, dynamic>> listData = await FirebaseFirestore
        .instance
        .collection('chat')
        .doc(docId)
        .collection('messages')
        .get();
    for (int i = 0; i < listData.docs.length; i++) {
      log('>>>>>>>${listData.docs[i]['senderId']}<<<<<<<<');
      if (!patientIds.contains(listData.docs[i]['senderId']) &&
          listData.docs[i]['senderId'] != user!.uid) {
        patientIds.add(listData.docs[i]['senderId']);
      }
    }
    getAllPatients(patientIds);
  }

  getAllPatients(List patientIds) async {
    log(patientIds.first.toString());
    for (int i = 0; i < patientIds.length; i++) {
      var v = await FirebaseFirestore.instance
          .collection('users')
          .doc(patientIds[i])
          .get();
      if (!allPatients.contains(v.data())) {
        allPatients.add(v.data());
      }
      // print(v.data().toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Container()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: allPatients.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                docId: allPatients[i]['id'],
                                docName: allPatients[i]['full_name'],
                                doc: true,
                              )));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(0, 0),
                            spreadRadius: 1,
                            blurRadius: 1,
                          )
                        ]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            allPatients[i]['full_name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.message,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
