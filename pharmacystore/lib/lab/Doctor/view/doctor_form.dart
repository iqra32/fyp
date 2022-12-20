import 'package:pharmacystore/lab/Services/auth_services.dart';

import '../../Components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../../Components/auth_button.dart';
import '../../Nearby/location_model.dart';
import '../../Nearby/location_services.dart';
import '../../Services/database_services.dart';

class DoctorForm extends StatefulWidget {
  const DoctorForm({Key? key}) : super(key: key);

  @override
  _DoctorFormState createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final _formKey = GlobalKey<FormState>();
  String? clinicName;
  String? clinicAddress;
  String? docName;
  String? phoneNumber;
  String? docQualification;
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return check
        ? Scaffold(
            body: Center(
              child: Container(
                height: 200,
                child: Lottie.asset('assets/heart.json'),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Add your laboratory details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        CustomTextField(
                          hintText: 'Clinic Name',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Clinic name';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            clinicName = val;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                          hintText: 'Clinic Address',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Clinic address';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            clinicAddress = val;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                          hintText: 'Doctor Name',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Doctor Name';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            docName = val;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          keyBoardType: TextInputType.phone,
                          hintText: 'Doctor Phone Number',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Doctor Phone Number';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            phoneNumber = val;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          keyBoardType: TextInputType.text,
                          hintText: 'Doctor Qualification',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Doctor Qualification';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            docQualification = val;
                          },
                        ),
                        const SizedBox(height: 30),
                        AuthButton(
                            title: 'Submit',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    check = true;
                                  });
                                  List position = await getLabLocation();

                                  await DatabaseServices().addDoctorToDatabase(
                                    clinicName!,
                                    clinicAddress!,
                                    docName!,
                                    phoneNumber!,
                                    docQualification!,
                                    position,
                                    AuthServices().getUid(),
                                  );
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: "Lab added successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } catch (e) {
                                  setState(() {
                                    check = false;
                                  });
                                }
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

Future getLabLocation() async {
  List position = [];
  LocationModel model = await LocationServices().getCurrentLocation();
  position.add({
    'Latitude': model.latitude.toString(),
    'Longitude': model.longitude.toString()
  });
  return position;
}
