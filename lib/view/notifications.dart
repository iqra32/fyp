import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/model/notification.dart';
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
                            onTap: () {
                              snapshot.data!.docs[index].reference
                                  .update({"isRead": false});
                            },
                            enabled: !(notification.isRead!),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            title: Text(notification.title!),
                            subtitle: Text(notification.description!),
                            trailing: Text(timeago
                                .format(notification.timestamp!.toDate())),
                          ),
                          Divider()
                        ],
                      );
                    });
              }
            }));
  }
}
