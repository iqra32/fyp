import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/lab/Screens/splash_screen.dart' as lab;
// import 'package:pharmacystore/lab/Screens/info_page.dart' as info;

// options:const FirebaseOptions(apiKey: "AIzaSyBakAb8fXW7Njeejw5SYzaaWVmizumIn8Y",
//  appId: "1:774691953658:android:2ba97cf95d4d731c2d6243",
//   messagingSenderId: "774691953658",
//    projectId: "pharmacy-1db45")
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomeView(),
      home: lab.SplashScreen(),
      // home: info.dashboard(
      //   userName: "Adnan",
      // ),
    );
  }
}
