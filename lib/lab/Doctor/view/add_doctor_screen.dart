import 'package:flutter/material.dart';
import 'package:pharmacystore/docs/all_patient_chats_screen.dart';
import 'package:pharmacystore/lab/Doctor/view/doctor_form.dart';
import 'package:pharmacystore/lab/Doctor/view/manage_doctor_appointments.dart';
import 'package:pharmacystore/lab/Doctor/view/manage_doctor_screen.dart';

import '../../Screens/splash_screen.dart';
import '../../Services/auth_services.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({Key? key}) : super(key: key);

  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  int currentIndex = 0;

  getScreen() {
    if (currentIndex == 0) {
      return const ManageDoctor();
    } else if (currentIndex == 1) {
      return const ManageDoctorAppointment();
    } else {
      return const AllPatientMessagedScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const DoctorForm();
          }));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthServices().logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const SplashScreen();
                }));
              },
              icon: const Icon(
                Icons.logout,
              )),
        ],
      ),
      body: getScreen(),
    );
  }
}
