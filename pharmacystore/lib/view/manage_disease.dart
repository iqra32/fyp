import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/model/disease_medicine_model.dart';
import 'package:pharmacystore/view/edit_disease.dart';

import '../utils/app_colors.dart';

class ManageDisease extends StatelessWidget {
  const ManageDisease({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Manage Diseases"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditDisease(),
              ),
            ),
            title: const Text(
              "Add new disease",
              style: TextStyle(
                color: AppColors.appWhiteColor,
              ),
            ),
            tileColor: AppColors.primaryColor.withOpacity(0.5),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("medicines")
                .where("is_disease", isEqualTo: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  DiseaseMedicinesUsers diseaseMedicinesUsers =
                      DiseaseMedicinesUsers.fromJson(
                          snapshot.data.docs[index].data());
                  return ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditDisease(
                          diseaseMedicinesUsers: diseaseMedicinesUsers,
                        ),
                      ),
                    ),
                    tileColor: Colors.white,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          diseaseMedicinesUsers.title!,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          diseaseMedicinesUsers.description!,
                          style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14.0,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.edit),
                        const SizedBox(width: 10.0),
                        InkWell(
                          onTap: () => _delete(diseaseMedicinesUsers.id!),
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _delete(String id) async {
    await FirebaseFirestore.instance.collection("medicines").doc(id).delete();
  }
}
