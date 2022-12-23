import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacystore/firebase_functions/getUser.dart';
import 'package:pharmacystore/lab/Nearby/nearby_screen.dart';
import 'package:pharmacystore/lab/Screens/result_screen.dart';
import 'package:pharmacystore/lab/Screens/splash_screen.dart';
import 'package:pharmacystore/view/models/user_model.dart';
import 'package:pharmacystore/view/search.dart';

import '../../docs/all_docs_screen.dart';
import '../Services/auth_services.dart';
import 'appointment_screen.dart';

class NavigatorScreenForPatient extends StatefulWidget {
  const NavigatorScreenForPatient({Key? key}) : super(key: key);

  @override
  _NavigatorScreenForPatientState createState() =>
      _NavigatorScreenForPatientState();
}

class _NavigatorScreenForPatientState extends State<NavigatorScreenForPatient> {
  int currentIndex = 0;

  getScreen() {
    if (currentIndex == 0) {
      return NearByScreen();
    } else if (currentIndex == 1) {
      return const SearchScreen();
    } else if (currentIndex == 2) {
      return AppointmentScreen();
    } else if (currentIndex == 3) {
      return ResultScreen();
    } else {
      return AllDocsScreen();
    }
  }

  Users? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: 250,
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<DocumentSnapshot<Users>>(
                      stream: getUserStream(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Container(
                              height: 100,
                              child: Lottie.asset('assets/heart.json'),
                            ),
                          );
                        }
                        var item = snapshot.data!;
                        model = item.data()!;

                        return Column(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/profile.png'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              model!.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              model!.email,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        );
                      }),
                ],
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        onTap: (int) {
          setState(() {
            currentIndex = int;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_calendar_sharp),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: 'Doctors',
          ),
        ],
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            currentIndex == 0
                ? 'Nearby Labs'
                : currentIndex == 1
                    ? 'Search medicines | diseases'
                    : currentIndex == 2
                        ? 'Appointments'
                        : currentIndex == 3
                            ? 'Results'
                            : 'Doctors',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => TextButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            child: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () async {
                await AuthServices().logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return SplashScreen();
                }));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: getScreen(),
    );
  }
}
