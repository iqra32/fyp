import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/docs/chat_widgets/all_messages.dart';
import 'package:pharmacystore/docs/chat_widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  final String docId, docName;
  final bool doc;
  const ChatScreen(
      {Key? key, required this.docId, required this.docName, required this.doc})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 190,
              child: AllMessages(
                docId: widget.doc ? user!.uid : widget.docId,
              ),
            ),
            SizedBox(
                height: 90,
                child: NewMessage(
                  senderId: user!.uid,
                  receiverId: widget.docId,
                  isDoc: widget.doc,
                ))
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const SizedBox(
            width: 15,
          ),
          Text(
            widget.docName,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
