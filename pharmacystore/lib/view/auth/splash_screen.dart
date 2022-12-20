import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/firebase_functions/getUser.dart';
import 'package:pharmacystore/utils/data.dart';
import 'package:pharmacystore/view/admin/admin_home.dart';
import 'package:pharmacystore/view/auth/login_screen.dart';

import '../home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Widget> checkUser() async {
    Widget scr;
    var cu = FirebaseAuth.instance.currentUser;
    if (cu == null) {
      scr = SignIn();
      return Future.value(scr);
    } else {
      AppUser.data = await getUser();
      String role = AppUser.data!.role;
      switch (role) {
        case 'admin':
          {
            scr = AdminHomePage();
          }
          break;
        case 'user':
          {
            scr = HomeView();
          }
          break;
        case 'Pharmacist':
          {
            scr = HomeView();
          }
          break;
        default:
          {
            scr = HomeView();
          }
      }
      return Future.value(scr);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () async {
      var route = await checkUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => route));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
