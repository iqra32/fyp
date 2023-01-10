import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/model/model_medicine.dart';

import '../view/product_detail_screen.dart';

class MedicinesGrid extends StatelessWidget {
  const MedicinesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('medicines');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (!snapshot.hasData) {
          return Column(
            children: [
              const CircularProgressIndicator(),
            ],
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Text("No Data FOund");
        } else {
          return SizedBox(
            height: 250,
            child: medicineList(snapshot.data!.docs),
          );
        }
      },
    );
  }

  Widget medicineList(List<QueryDocumentSnapshot> snap) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.85
            // crossAxisSpacing: 20,
            // mainAxisSpacing: 20,
            ),
        itemCount: snap.length,
        itemBuilder: (context, index) {
          DocumentSnapshot obj = snap[index];

          Map data = obj.data() as Map;
          Medicine med = Medicine(
              id: data['id'] ?? "0",
              price: data['price'],
              imageurl: data["imageurl"],
              description: data["description"],
              title: data["title"],
              addedBy: data['addedBy'] ?? "");
          if (med.title == null) {
            obj.reference.delete(); // deletes null data objects from firebase
            return SizedBox();
          } else {
            return GestureDetector(
              onTap: () {
                // obj.reference.delete();
                // return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(
                      medicineName: med.title!,
                      medicineDetail: med.description!,
                      price: med.price!,
                      imageurl: med.imageurl!,
                      postedBy: med.addedBy ?? "",
                      medId: obj.reference.id,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 160, 62, 177)
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //net issue
                      // Image(
                      //   image: NetworkImage(Data.medicines[index].imageurl ?? ""),
                      // ),

                      med.imageurl == null
                          ? SizedBox(
                              height: 140,
                              child: Center(
                                child: Text("No Preview"),
                              ),
                            )
                          : med.imageurl!.isEmpty
                              ? SizedBox(
                                  height: 140,
                                  child: Center(
                                    child: Text("No Preview"),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    med.imageurl!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 140,
                                  ),
                                ),
                      const SizedBox(
                        height: 14,
                        // child: FlutterLogo(
                        //   size: 100,
                        // ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        child: Text(
                          med.title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 0.6),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Rs ${med.price ?? "0"}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
