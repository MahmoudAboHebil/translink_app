import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/constants.dart';
import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../peinding_processing_page/peinding_processing_page.dart';
import 'components/message_stream.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'Chat_Screen';
  Customer customer;
  Operation operation;

  ChatScreen(this.customer, this.operation);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  // final _auth = FirebaseAuth.instance;
  var messagesText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentUser();
  }

  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void messagesStream() async {
  //   await for (var snapshot in _fireStore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  Widget getButton() {
    String? text;
    if (widget.operation.stateOfOperation ==
        StateOfOperation.Canceled_Completed) {
      text = 'Canceled';
    } else if (widget.operation.stateOfOperation ==
        StateOfOperation.Completed_Completed) {
      text = 'Completed';
    } else if (widget.operation.stateOfOperation ==
        StateOfOperation.Paid_Pending) {
      text = 'Processing';
    }
    if (text == null) {
      return Container(
        height: 40,
        width: 130,
        child: ElevatedButton(
          // color: Color(0xff7d53f3),
          style: ButtonStyle(
              // elevation: MaterialStatePropertyAll(10),
              // shadowColor: MaterialStatePropertyAll(Color(0xff7d53f3)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
              alignment: Alignment.center,
              backgroundColor: MaterialStatePropertyAll(Color(0xff7d53f3))),
          onPressed: () {
            FirebaseServices fireServ = FirebaseServices();

            fireServ.changeTheStateOfOperation(widget.operation,
                widget.customer, StateOfOperation.Paid_Pending, null, false);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PendingProcessingPage(
                      widget.operation, widget.customer, false),
                ));
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Make Payment',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff2e0073),
          Color(0xff4b00b8),
        ])),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    alignment: Alignment.topLeft,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(flex: 2),
                              Text(
                                'Chat',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Spacer(flex: 3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xfffafafa),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: 5, left: 20, right: 20, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Send Amount',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '${widget.operation.sendAmount} ${widget.operation.sendBank.currency}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                    getButton(),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                width: 140,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )
                            ],
                          ),
                          MessageStream(widget.customer, widget.operation),
                          Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: kMessageContainerDecoration,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStatePropertyAll(
                                          Size(30, 30)),
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.all(0)),
                                      shape: MaterialStatePropertyAll(
                                          CircleBorder()),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.grey.shade400)),
                                  onPressed: () async {},
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: messageTextController,
                                    onChanged: (value) {
                                      setState(() {
                                        messagesText = value;
                                      });
                                    },
                                    decoration: kMessageTextFieldDecoration,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (messageTextController.text.isNotEmpty) {
                                      setState(() {
                                        messageTextController.text = '';
                                      });
                                      await FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(widget.customer.email)
                                          .collection('Operations')
                                          .doc(widget.operation.operationId)
                                          .collection('messages')
                                          .add(
                                        {
                                          'text': messagesText,
                                          'sender': widget.customer.email,
                                          'date and time':
                                              DateTime.now().toString(),
                                        },
                                      );
                                    }
                                  },
                                  child: Icon(Icons.send),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     leading: null,
    //     actions: <Widget>[
    //       IconButton(
    //           icon: Icon(Icons.close),
    //           onPressed: () {
    //             // _auth.signOut();
    //             Navigator.pop(context);
    //           }),
    //     ],
    //     title: Text('⚡️Chat'),
    //     backgroundColor: Colors.lightBlueAccent,
    //   ),
    //   body: SafeArea(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: <Widget>[
    //         MessageStream(widget.customer, widget.operation),
    //         Container(
    //           decoration: kMessageContainerDecoration,
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               Expanded(
    //                 child: TextField(
    //                   controller: messageTextController,
    //                   onChanged: (value) {
    //                     messagesText = value;
    //                   },
    //                   decoration: kMessageTextFieldDecoration,
    //                 ),
    //               ),
    //               TextButton(
    //                 onPressed: () async {
    //                   messageTextController.clear();
    //                   await FirebaseFirestore.instance
    //                       .collection('Users')
    //                       .doc(widget.customer.email)
    //                       .collection('Operations')
    //                       .doc(widget.operation.operationId)
    //                       .collection('messages')
    //                       .add(
    //                     {
    //                       'text': messagesText,
    //                       'sender': widget.customer.email,
    //                       'date and time': DateTime.now().toString(),
    //                     },
    //                   );
    //                 },
    //                 child: Text(
    //                   'Send',
    //                   style: kSendButtonTextStyle,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
