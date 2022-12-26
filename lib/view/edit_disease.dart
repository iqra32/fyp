import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacystore/model/disease_medicine_model.dart';
import 'package:pharmacystore/utils/app_colors.dart';
import 'package:pharmacystore/view/models/user_model.dart';

import '../lab/Components/auth_button.dart';

class EditDisease extends StatefulWidget {
  final DiseaseMedicinesUsers? diseaseMedicinesUsers;
  const EditDisease({
    Key? key,
    this.diseaseMedicinesUsers,
  }) : super(key: key);

  @override
  State<EditDisease> createState() => _EditDiseaseState();
}

class _EditDiseaseState extends State<EditDisease> {
  List<String> associatedUser = [];
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    addDefaultValuesToControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.diseaseMedicinesUsers == null
              ? "Add Disease"
              : "Update Disease",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.diseaseMedicinesUsers == null
                      ? "Add New Disease"
                      : "Update Disease",
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                const Text(
                  "Disease Title",
                  style: TextStyle(
                    color: AppColors.appBlackColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.appGreyColor.withOpacity(0.10),
                    hintText: widget.diseaseMedicinesUsers == null
                        ? 'Enter Disease Title'
                        : widget.diseaseMedicinesUsers!.title,
                    enabled: true,
                    contentPadding: const EdgeInsets.only(
                      left: 14.0,
                      bottom: 8.0,
                      top: 8.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Disease Description",
                  style: TextStyle(
                    color: AppColors.appBlackColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.appGreyColor.withOpacity(0.10),
                    hintText: widget.diseaseMedicinesUsers == null
                        ? 'Enter Disease Description'
                        : widget.diseaseMedicinesUsers!.description,
                    enabled: true,
                    contentPadding: const EdgeInsets.only(
                      left: 14.0,
                      bottom: 8.0,
                      top: 8.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Associate Users",
                  style: TextStyle(
                    color: AppColors.appBlackColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("role", isNotEqualTo: "user")
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data.docs.length == 0) {
                      return const Text("No users available for association");
                    }
                    List<Users> users = [];
                    snapshot.data.docs.forEach((element) {
                      users.add(Users.fromJson(element.data()));
                    });
                    return Wrap(
                      children: users
                          .map(
                            (e) => InkWell(
                              onTap: () => makeAssociatedUser(e),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: associatedUser.contains(e.id)
                                      ? AppColors.textColor.withOpacity(0.25)
                                      : AppColors.appWhiteColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: associatedUser.contains(e.id)
                                      ? null
                                      : Border.all(color: AppColors.textColor),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 20.0,
                                ),
                                child: Text(e.name),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 50.0),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : AuthButton(
                        textAlign: TextAlign.center,
                        title: widget.diseaseMedicinesUsers == null
                            ? "Add Disease"
                            : "Update Disease",
                        onTap: () => processDisease(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void processDisease() async {
    String title = titleController.text.trim().toString();
    String description = descriptionController.text.trim().toString();

    if (widget.diseaseMedicinesUsers != null &&
        (title == widget.diseaseMedicinesUsers!.title)) {
      Fluttertoast.showToast(msg: "Enter updated title to proceed");
      return;
    } else if (widget.diseaseMedicinesUsers != null &&
        (description == widget.diseaseMedicinesUsers!.description)) {
      Fluttertoast.showToast(msg: "Enter updated description to proceed");
      return;
    } else if (title.isEmpty) {
      Fluttertoast.showToast(msg: "Title must not be empty");
      return;
    } else if (description.isEmpty) {
      Fluttertoast.showToast(msg: "Description must not be empty");
      return;
    } else {
      setState(() {
        isLoading = true;
      });
      // add keywords of this disease to all associated users
      for (var userID in associatedUser) {
        FirebaseFirestore.instance.collection("users").doc(userID).update({
          "keywords": FieldValue.arrayUnion([title.toLowerCase()])
        });
      }
      // upload / update this disease
      if (widget.diseaseMedicinesUsers != null) {
        // update
        DocumentReference diseaseRef = FirebaseFirestore.instance
            .collection("medicines")
            .doc(widget.diseaseMedicinesUsers!.id);
        DiseaseMedicinesUsers medicinesUsers = DiseaseMedicinesUsers(
          isMedicine: false,
          isDisease: true,
          title: title,
          description: description,
        );
        await diseaseRef.update(medicinesUsers.toJson());
      } else {
        // add
        DocumentReference diseaseRef =
            FirebaseFirestore.instance.collection("medicines").doc();
        DiseaseMedicinesUsers medicinesUsers = DiseaseMedicinesUsers(
          isMedicine: false,
          isDisease: true,
          title: title,
          description: description,
          id: diseaseRef.id,
          addedBy: FirebaseAuth.instance.currentUser!.uid,
        );
        await diseaseRef.set(medicinesUsers.toJson());
      }
      Navigator.of(context).pop();
    }
  }

  void makeAssociatedUser(Users user) {
    if (!associatedUser.contains(user.id)) {
      associatedUser.add(user.id);
    }
    setState(() {});
  }

  void addDefaultValuesToControllers() {
    if (widget.diseaseMedicinesUsers != null) {
      titleController.text = widget.diseaseMedicinesUsers!.title!;
      descriptionController.text = widget.diseaseMedicinesUsers!.description!;
    }
    setState(() {});
  }
}
