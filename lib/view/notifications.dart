import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/model/notification.dart';
import 'package:pharmacystore/utils/data.dart';
import 'package:pharmacystore/utils/refs.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          backgroundColor: Colors.purple,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FBCollections.notifications
                .where('sentFor',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .orderBy("timestamp", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("Not Notifications avaialble yet"),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      NotificationModel notification =
                          NotificationModel.fromJson(snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>);

                      return Column(
                        children: [
                          ListTile(
                            onTap: () async {
                              snapshot.data!.docs[index].reference
                                  .update({"isRead": false});
                              if (notification.type == 'delivery') {
                                var res = (await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                Text("Deliver the order now?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: Text("Maybe Later")),
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child: Text("Ok"))
                                            ],
                                          );
                                        })) ??
                                    false;
                                if (!res) return;
                                NotificationModel n = NotificationModel(
                                  sentby:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  sentFor: notification.sentby,
                                  title: "Medicine order delivery",
                                  isRead: false,
                                  deliveryStatus: "delivered",
                                  type: 'delivered',
                                  medId: notification.medId,
                                  description:
                                      "${AppUser.data!.name} has delivered your order",
                                  timestamp: Timestamp.now(),
                                  location: const GeoPoint(0.0, 0.0),
                                );
                                await FBCollections.notifications
                                    .doc()
                                    .set(n.toJson());
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Order delivered",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  "Your order has been delivered successfully"),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.purple),
                                                  child: const Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }
                              if (notification.type == 'delivered') {
                                var res = (await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Send confirmation message"),
                                            content: Text(
                                                "Send a message to pharmacy to confirm that you have received the medicine"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: Text("Maybe Later")),
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child: Text("Ok"))
                                            ],
                                          );
                                        })) ??
                                    false;
                                if (!res) return;
                                NotificationModel n = NotificationModel(
                                  sentby:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  sentFor: notification.sentby,
                                  title: "Medicine Received",
                                  isRead: false,
                                  deliveryStatus: "received",
                                  type: 'received',
                                  medId: notification.medId,
                                  description:
                                      "${AppUser.data!.name} has received your order",
                                  timestamp: Timestamp.now(),
                                  location: const GeoPoint(0.0, 0.0),
                                );
                                await FBCollections.notifications
                                    .doc()
                                    .set(n.toJson());
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Confirmation sent",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  "Medicine delivery confirmation sent to pharmacy"),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.purple),
                                                  child: const Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }
                            },
                            enabled: !(notification.isRead!),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            title: Text(notification.title!),
                            subtitle: Text(notification.description!),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(timeago
                                    .format(notification.timestamp!.toDate())),
                                Text(
                                  notification.type ?? "",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      );
                    });
              }
            }));
  }
}
