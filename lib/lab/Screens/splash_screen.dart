import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacystore/firebase_functions/getUser.dart';
import 'package:pharmacystore/lab/Doctor/view/add_doctor_screen.dart';
import 'package:pharmacystore/lab/Doctor/view/home_screen_for_doctor.dart';
import 'package:pharmacystore/lab/Screens/info_page.dart';
import 'package:pharmacystore/lab/goto_screen.dart';
import 'package:pharmacystore/utils/data.dart';
import 'package:pharmacystore/view/admin/admin_home.dart';
import 'package:pharmacystore/view/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkUser() async {
    var cu = FirebaseAuth.instance.currentUser;
    if (cu == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return GotoPage();
      }));
    } else {
      AppUser.data = await getUser();
      String role = AppUser.data!.role;

      navigateToRole(role, context);
    }
  }

  @override
  void initState() {
    super.initState();
    // FirebaseAuth.instance.signOut();
    Timer(Duration(seconds: 2), () {
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/splash.json'),
      ),
    );
  }
}

void navigateToRole(String role, context) {
  Widget page;
  log("going to role: $role");
  if (FirebaseAuth.instance.currentUser == null) {
    page = const GotoPage();
  } else {
    switch (role) {
      case "lab":
        {
          page = const HomeScreenForDoctor();
        }
        break;
      case "doctor":
        {
          page = const AddDoctorScreen();
        }
        break;
      case 'admin':
        {
          page = const AdminHomePage();
        }
        break;

      case "user":
        {
          page = const DashboardScreen();
        }
        break;
      case "Pharmacist":
        {
          page = const HomeView();
        }
        break;
      // case "patient":
      //   {
      //     page = const NavigatorScreenForPatient();
      //   }
      // break;
      default:
        {
          page = const GotoPage();
        }
        break;
    }
  }
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return page;
  }), (route) => false);
}
