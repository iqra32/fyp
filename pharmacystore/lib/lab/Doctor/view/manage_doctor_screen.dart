import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/lab/Doctor/Model/doctor_model.dart';

import '../Services/services.dart';

class ManageDoctor extends StatelessWidget {
  const ManageDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              const Text(
                'Manage Doctors',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 40),
              StreamBuilder<QuerySnapshot>(
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
                            onLongPress: () {
                              // AlertDialog alert = AlertDialog(
                              //   title: const Text("Warning"),
                              //   content:
                              //       const Text("Do you want to delete the Lab"),
                              //   actions: [
                              //     InkWell(
                              //       onTap: () {
                              //         Services().deleteLab(labs[i].labId);
                              //         Navigator.pop(context);
                              //       },
                              //       child: Container(
                              //         height: 40,
                              //         width: 100,
                              //         decoration: BoxDecoration(
                              //           color: Colors.red[800],
                              //           borderRadius: BorderRadius.circular(5),
                              //         ),
                              //         alignment: Alignment.center,
                              //         child: const Text(
                              //           'Delete',
                              //           style: TextStyle(
                              //               color: Colors.white,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // );

                              // show the dialog
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return alert;
                              //   },
                              // );
                            },
                            // onTap: () {
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) {
                            //     return PendingAppointments(
                            //       labId: labs[i].labId,
                            //       labName: labs[i].labName,
                            //       address: labs[i].address,
                            //       doctor: labs[i].docName,
                            //       phoneNumber: labs[i].phoneNumber,
                            //     );
                            //   }));
                            // },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                                child: Column(
                                  children: [
                                    Text(
                                      doctors[i].docName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
