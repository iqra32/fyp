import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String senderId, receiverId;
  final bool isDoc;
  const NewMessage(
      {Key? key,
      required this.senderId,
      required this.receiverId,
      required this.isDoc})
      : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.isDoc ? widget.senderId : widget.receiverId)
          .collection('messages')
          .add({
        'text': _controller.text,
        'createdAt': Timestamp.now(),
        'senderId': widget.senderId,
        'receiverId': widget.receiverId
        // 'full_name': userData['full_name'],
      });
      _controller.clear();
    } else {
      log('Type Something');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            textDirection: TextDirection.ltr,
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Send a message'),
          )),
          IconButton(
            color: Colors.blueGrey,
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
