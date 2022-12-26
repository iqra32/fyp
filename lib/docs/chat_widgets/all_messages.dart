import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_bubbles.dart';

class AllMessages extends StatefulWidget {
  const AllMessages({Key? key, required this.docId}) : super(key: key);
  final String docId;
  @override
  State<AllMessages> createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .doc(widget.docId)
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final chatDoc = chatSnapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDoc.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatDoc[index]['text'] ?? '',
              chatDoc[index]['senderId'] == user!.uid,
            ),
          );
        });
  }
}
