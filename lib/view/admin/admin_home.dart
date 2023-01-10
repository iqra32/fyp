import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/lab/Services/auth_services.dart';
import 'package:pharmacystore/view/admin/Feedbacks_admin_view.dart';
import 'package:pharmacystore/view/manage_disease.dart';

import '../../lab/Screens/splash_screen.dart';
import '../manage_users.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF800080),
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              await AuthServices().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SplashScreen();
                  },
                ),
              );
            },
            child: const Icon(Icons.login),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SuperAdminCard(
                  title: "Manage Diseases",
                  image: "disease.jpeg",
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ManageDisease(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SuperAdminCard(
                  title: "Manage Doctors",
                  image: "doctor.jpeg",
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ManageUsers(role: "doctor"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SuperAdminCard(
                  title: "Manage Medical Stores",
                  image: "pharmacy.jpeg",
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const ManageUsers(role: "Pharmacist"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SuperAdminCard(
                  title: "Manage Laboratory",
                  image: "lab.jpeg",
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ManageUsers(role: "lab"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SuperAdminCard(
                  title: "Feedbacks",
                  image: "pharmacy.jpeg",
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FeedbacksAdminView(),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

class SuperAdminCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onPressed;
  const SuperAdminCard(
      {Key? key, required this.title, required this.image, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 160,
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Color(0xff800080),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/icons/$image',
                fit: BoxFit.fill,
                height: 100.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
