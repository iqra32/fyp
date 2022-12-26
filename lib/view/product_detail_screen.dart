import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacystore/lab/Nearby/location_model.dart';
import 'package:pharmacystore/lab/Nearby/location_services.dart';
import 'package:pharmacystore/model/notification.dart';
import 'package:pharmacystore/utils/data.dart';
import 'package:pharmacystore/utils/refs.dart';
import 'package:pharmacystore/view/google_map.dart';
import 'package:pharmacystore/view/models/user_model.dart';

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
          child: FutureBuilder<DocumentSnapshot>(
              future: FBCollections.users.doc(widget.postedBy).get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                if (userSnapshot.hasData) {
                  if (userSnapshot.data != null) {
                    Users _user = Users.fromJson(
                        userSnapshot.data!.data() as Map<String, dynamic>);
                    // userSnapshot.data!.reference
                    //     .update({"geopoint": GeoPoint(31.0, 74.0)});
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          child: Text(
                            userSnapshot.data!['full_name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontSize: 20),
                          ),
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
                        GoogleMapForPharmacy(
                          pharmacyLocation: LatLng(_user.geopoint.latitude,
                              _user.geopoint.longitude),
                        ),
                      ],
                    );
                  } else {
                    return Text("");
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (AppUser.data!.role == "Pharmacist")
              // if (widget.showDeliverButton)
              //   ElevatedButton(
              //     style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all(Colors.purple),
              //     ),
              //     onPressed: () async {
              //       NotificationModel n = NotificationModel(
              //           sentby: FirebaseAuth.instance.currentUser!.uid,
              //           sentFor: widget.postedBy,
              //           title: "${widget.medicineName} delivered",
              //           isRead: false,
              //           deliveryStatus: "delivered",
              //           type: 'delivery',
              //           medId: widget.medId,
              //           description:
              //               "${widget.medicineName} has been delivered to customer",
              //           timestamp: Timestamp.now());
              //       await FBCollections.notifications.doc().set(n.toJson());
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return Dialog(
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   const Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Text(
              //                       "Delivered",
              //                       style: TextStyle(
              //                           fontSize: 20,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ),
              //                   const Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child:
              //                         Text("Your medicine has been delivered"),
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: TextButton(
              //                         onPressed: () {
              //                           Navigator.pop(context);
              //                         },
              //                         style: TextButton.styleFrom(
              //                             backgroundColor: Colors.purple),
              //                         child: Text(
              //                           "Ok",
              //                           style: TextStyle(color: Colors.white),
              //                         )),
              //                   )
              //                 ],
              //               ),
              //             );
              //           });
              //     },
              //     child: Text("Delivered"),
              //   ),
              if (!widget.showDeliverButton)
                if (widget.postedBy == FirebaseAuth.instance.currentUser!.uid)
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    onPressed: () async {
                      await FBCollections.medicines.doc(widget.medId).delete();
                      Navigator.pop(context);
                    },
                    child: Text("Delete"),
                  ),
            if (AppUser.data!.role != "Pharmacist")
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    onPressed: () async {
                      NotificationModel n = NotificationModel(
                          sentby: FirebaseAuth.instance.currentUser!.uid,
                          sentFor: widget.postedBy,
                          title: "${widget.medicineName} reserved",
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
                                    child:
                                        Text("Your medicine has been Reserved"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.purple),
                                        child: const Text(
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
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    onPressed: () async {
                      var res = (await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      "Your current location will be submitted along with the order"),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text("No")),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text("Ok"))
                                  ],
                                );
                              })) ??
                          false;
                      if (!res) return;
                      LocationModel? cl =
                          await LocationServices().getCurrentLocation();
                      GeoPoint gp = GeoPoint(34.0, 73.0);
                      if (cl != null) {
                        gp = GeoPoint(gp.longitude, gp.latitude);
                      }
                      NotificationModel n = NotificationModel(
                          sentby: FirebaseAuth.instance.currentUser!.uid,
                          sentFor: widget.postedBy,
                          title: "new order for ${widget.medicineName}",
                          isRead: false,
                          deliveryStatus: "pending",
                          type: 'delivery',
                          medId: widget.medId,
                          description:
                              "${AppUser.data!.name} has placed an order for ${widget.medicineName}",
                          timestamp: Timestamp.now(),
                          location: gp);
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
                                      "Order Placed",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        "Your order for ${widget.medicineName} has been placed successfully"),
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
                    child: Text("Deliver"),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
