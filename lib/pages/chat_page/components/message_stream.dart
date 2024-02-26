import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/operation/operation.dart';
import '../../../models/person.dart';
import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
  Customer customer;
  Operation operation;

  MessageStream(this.customer, this.operation);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(customer.email)
          .collection('Operations')
          .doc(operation.operationId)
          .collection('messages')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = (snapshot.data! as QuerySnapshot).docs.reversed;
          List<MessageBubble> messageBubbles = [];
          // for (int i = 0; i < messages.length; i++) {
          //   final messagetext = messages[i]['test'];
          //   final messageSender = messages[i]['sender'];
          //   bool check = messageSender == loggedInUser.email;
          //   print(check);
          //   final messageBubble =
          //       MessageBubble(messagetext, messageSender, check);
          //   messageBubbles.add(messageBubble);
          // }
          for (var message in messages) {
            final messagetext = message['text'];
            final messageSender = message['sender'];
            final messageDateTime = message['date and time'];
            bool check = messageSender == customer.email;

            final messageBubble = MessageBubble(
                messagetext, messageSender, check, messageDateTime);
            messageBubbles.add(messageBubble);
            messageBubbles.sort((a, b) => DateTime.parse(b.dateTime)
                .compareTo(DateTime.parse(a.dateTime)));
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.lightBlueAccent,
            ),
          );
        }
      },
    );
  }
}
