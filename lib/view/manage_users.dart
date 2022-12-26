import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/view/models/user_model.dart';

import '../utils/app_colors.dart';

class ManageUsers extends StatelessWidget {
  final String role;
  const ManageUsers({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Manage $role"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("role", isEqualTo: role)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          print(snapshot.data.docs.length);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              Users user = Users.fromJson(snapshot.data.docs[index].data());
              return ListTile(
                tileColor: Colors.white,
                title: Text(
                  user.name,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Profile status:",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18.0,
                          ),
                        ),
                        Switch(
                          value: user.isAllowed,
                          onChanged: (updatedValue) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(user.id)
                                .update({
                              "is_allowed": updatedValue,
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
