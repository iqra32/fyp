import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/lab/goto_screen.dart';
import 'package:pharmacystore/utils/data.dart';

import '../firebase_functions/Add_medicine.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // Important: Remove any padding from the ListView.

        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text("Pharmacy Store"),
            ),
          ),
          if (AppUser.data!.role == 'Pharmacist')
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
              title: const Text('Add Medicines'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddMedicine()));
              },
            ),
          // ListTile(
          //   leading: IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.add),
          //   ),
          //   title: const Text('User Orders'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => AddMedicine()));
          //   },
          // ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {},
              ),
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (c) => GotoPage()),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
