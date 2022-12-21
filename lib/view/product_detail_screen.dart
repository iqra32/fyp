import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/model/notification.dart';
import 'package:pharmacystore/utils/data.dart';
import 'package:pharmacystore/utils/refs.dart';

class DetailsScreen extends StatefulWidget {
  final String medicineDetail;
  final String medicineName;
  final String imageurl;
  final String price;
  final String postedBy;
  final String medId;
  final bool showDeliverButton;

  DetailsScreen(
      {Key? key,
      required this.medicineDetail,
      required this.medicineName,
      required this.price,
      required this.imageurl,
      required this.medId,
      required this.postedBy,
      this.showDeliverButton = false})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        title: Text(widget.medicineName),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: FutureBuilder<DocumentSnapshot>(
                    future: FBCollections.users.doc(widget.postedBy).get(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                      if (userSnapshot.hasData) {
                        if (userSnapshot.data != null) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 5, bottom: 5),
                            child: Text(
                              userSnapshot.data!['full_name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontSize: 20),
                            ),
                          );
                        } else {
                          return Text("");
                        }
                      } else {
                        return LinearProgressIndicator();
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.imageurl,
                  fit: BoxFit.cover,
                  height: size.height * 0.35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.medicineDetail,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (AppUser.data!.role == "Pharmacist")
              if (widget.showDeliverButton)
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () async {
                    NotificationModel n = NotificationModel(
                        sentby: FirebaseAuth.instance.currentUser!.uid,
                        sentFor: widget.postedBy,
                        title: "${widget.medicineName} delivered",
                        isRead: false,
                        deliveryStatus: "delivered",
                        type: 'delivery',
                        medId: widget.medId,
                        description:
                            "${widget.medicineName} has been delivered to customer",
                        timestamp: Timestamp.now());
                    await FBCollections.notifications.doc().set(n.toJson());
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Delivered",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text("Your medicine has been delivered"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.purple),
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Text("Delivered"),
                ),
            if (!widget.showDeliverButton)
              if (widget.postedBy == FirebaseAuth.instance.currentUser!.uid)
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () async {
                    await FBCollections.notifications
                        .doc(widget.medId)
                        .delete();
                    Navigator.pop(context);
                  },
                  child: Text("Delete"),
                ),
            if (AppUser.data!.role != "Pharmacist")
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                onPressed: () async {
                  NotificationModel n = NotificationModel(
                      sentby: FirebaseAuth.instance.currentUser!.uid,
                      sentFor: widget.postedBy,
                      title: "${widget.medicineName} delivered",
                      isRead: false,
                      deliveryStatus: "pending",
                      type: 'reservation',
                      medId: widget.medId,
                      description:
                          "${AppUser.data!.name} has reserved ${widget.medicineName}",
                      timestamp: Timestamp.now());
                  await FBCollections.notifications.doc().set(n.toJson());
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Reserved",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Your medicine has been Reserved"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.purple),
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Text("Reserved"),
              )
          ],
        ),
      ),
    );
  }
}
