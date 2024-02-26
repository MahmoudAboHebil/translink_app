import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../enumes/enums.dart';
import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../chat_page/chat_page.dart';

class OrderCanceledPage extends StatefulWidget {
  Operation operation;
  Customer customer;

  OrderCanceledPage(this.customer, this.operation);

  @override
  State<OrderCanceledPage> createState() => _OrderCanceledPageState();
}

class _OrderCanceledPageState extends State<OrderCanceledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    'Order Details',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.operation.receiveAmount.toStringAsFixed(2)} ${widget.operation.receiveBank.currency}',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.circleExclamation,
                        color: Colors.grey.shade400,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Canceled',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),

                      // Exclamation
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You have cancelled the order',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      // fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurStyle: BlurStyle.outer,
                        color: Colors.grey.shade300,
                        blurRadius: 3,
                        spreadRadius: 0.1)
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    widget.customer, widget.operation),
                              ));
                        },
                        child: Icon(
                          Icons.chat,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Send Amount',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '${widget.operation.sendAmount} ${widget.operation.sendBank.currency}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '${widget.operation.price} ${Currency.EGP.name}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Receive Amount',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '${widget.operation.receiveAmount} ${widget.operation.receiveBank.currency}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurStyle: BlurStyle.outer,
                        color: Colors.grey.shade300,
                        blurRadius: 3,
                        spreadRadius: 0.1)
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Send Bank',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '${widget.operation.sendBank.bankName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Receive Bank',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '${widget.operation.receiveBank.bankName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Number',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '273486321876487',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Created Time',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '${DateFormat().add_yMd().add_jms().format(widget.operation.dataOfBegin)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
