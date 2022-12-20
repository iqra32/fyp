import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacystore/utils/enums.dart';

import 'Screens/Authentication/toggle_screen.dart';

class GotoPage extends StatelessWidget {
  const GotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isNotPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 30, vertical: isNotPortrait ? 80 : 50),
            child: Column(
              crossAxisAlignment: isNotPortrait
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                ),
                const Text(
                  'Welcome to the \nMedical health care',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Register or Login as:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ToggleScreen(
                        cast: UserRole.patient,
                      );
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Patient',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ToggleScreen(
                        cast: UserRole.pharmacist,
                      );
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Pharmacy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ToggleScreen(
                        cast: UserRole.doctor,
                      );
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Doctor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ToggleScreen(
                        cast: UserRole.lab,
                      );
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Lab',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ToggleScreen(
                        cast: UserRole.admin,
                      );
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 300,
                  child: Lottie.asset('assets/docter.json'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
