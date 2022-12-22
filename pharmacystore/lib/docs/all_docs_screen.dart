import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/docs/chat_screen.dart';

import '../lab/Doctor/Model/doctor_model.dart';
import '../lab/Doctor/Services/services.dart';

class AllDocsScreen extends StatefulWidget {
  const AllDocsScreen({Key? key}) : super(key: key);

  @override
  State<AllDocsScreen> createState() => _AllDocsScreenState();
}

class _AllDocsScreenState extends State<AllDocsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Services().getDoctorsList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<DoctorModel> doctors = [];
            var listData = snapshot.data!.docs;
            for (var item in listData) {
              DoctorModel model = DoctorModel(
                clinicName: item.get('clinicName'),
                clinicAddress: item.get('clinicAddress'),
                docName: item.get('docName'),
                phoneNumber: item.get('phoneNumber'),
                docQualification: item.get('docQualification'),
                docId: item.get('Doctor Id'),
              );
              //  LabModel(
              //     phoneNumber: item.get('Phone Number'),
              //     address: item.get('Address'),
              //     docName: item.get('Doctor'),
              //     labName: item.get('Lab Name'),
              //     labId: item.id);
              doctors.add(model);
            }
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: doctors.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    docId: doctors[i].docId,
                                    docName: doctors[i].docName,
                                    doc: false,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
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
                              Row(
                                children: [
                                  Text(
                                    doctors[i].docName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '  (${doctors[i].docQualification})',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10),
                                  ),
                                ],
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
          }),
    );
  }
}
