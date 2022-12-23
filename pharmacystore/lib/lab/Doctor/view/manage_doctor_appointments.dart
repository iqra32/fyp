import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/lab/Doctor/Model/doctor_appointment_model.dart';
import 'package:pharmacystore/lab/Services/auth_services.dart';

import '../Services/services.dart';

class ManageDoctorAppointment extends StatelessWidget {
  const ManageDoctorAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Manage your appointments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: Services().getDoctorAppointments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: SizedBox(
                        height: 100,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  List<DoctorAppointmentModel> appointments = [];
                  var listData = snapshot.data!.docs;
                  for (var item in listData) {
                    DoctorAppointmentModel model = DoctorAppointmentModel(
                      // nodeId: item.id,
                      uid: item.get('User Id'),
                      doctorConsultation: item.get('Doctor Consultation'),
                      doctorId: item.get('Doc Id'),
                      phoneNumber: item.get('Phone Number'),
                      // address: item.get('Address'),
                      fName: item.get('Father Name'),
                      gender: item.get('Gender'),
                      name: item.get('Name'),
                      age: item.get('Age'),
                      time: item.get('Appointment Time'),
                    );
                    appointments.add(model);
                    log(AuthServices()
                        .getUid()
                        .toString()
                        .compareTo(appointments[0].doctorId)
                        .toString());
                  }
                  if (appointments.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'No available Appointments',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appointments.length,
                      itemBuilder: (context, i) {
                        String? a;
                        if (appointments[i].time != null &&
                            appointments[i].time.length > 0) {
                          a = appointments[i]
                              .time
                              .substring(0, appointments[i].time.length - 7);
                        }
                        return AuthServices()
                                    .getUid()
                                    .toString()
                                    .compareTo(appointments[0].doctorId) ==
                                0
                            ? InkWell(
                                // onTap: () {
                                //   Navigator.push(context,
                                //       MaterialPageRoute(builder: (context) {
                                //     return SendResultScreen(
                                //         pName: appointments[i].name,
                                //         pFName: appointments[i].fName,
                                //         pNumber: appointments[i].phoneNumber,
                                //         pAge: appointments[i].age,
                                //         uid: appointments[i].uid,
                                //         labName: appointments[i].labName,
                                //         docConsultation:
                                //             appointments[i].doctorConsultation);
                                //   }));
                                // },
                                // onLongPress: () {
                                //   AlertDialog alert = AlertDialog(
                                //     title: const Text("Warning"),
                                //     content: const Text(
                                //         "Do you want to delete the appointment"),
                                //     actions: [
                                //       InkWell(
                                //         onTap: () {
                                //           Services()
                                //               .deleteApp(appointments[i].nodeId);
                                //           Navigator.pop(context);
                                //         },
                                //         child: Container(
                                //           height: 40,
                                //           width: 100,
                                //           decoration: BoxDecoration(
                                //             color: Colors.red[800],
                                //             borderRadius: BorderRadius.circular(5),
                                //           ),
                                //           alignment: Alignment.center,
                                //           child: const Text(
                                //             'Delete',
                                //             style: TextStyle(
                                //                 color: Colors.white,
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   );

                                //   // show the dialog
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return alert;
                                //     },
                                //   );
                                // },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'You have an appointment with ${appointments[i].name} at ${appointments[i].time}.',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Timings: $a',
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                        Text(
                                          'Patient Phone Number:  ${appointments[i].phoneNumber}',
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                        Text(
                                          appointments[i].doctorConsultation ==
                                                  'Yes'
                                              ? 'Doctor consultation of test result is required'
                                              : 'Doctor consultation of test result is not required',
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'No available Appointments',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                      });
                })
          ],
        ),
      ),
    );
  }
}
