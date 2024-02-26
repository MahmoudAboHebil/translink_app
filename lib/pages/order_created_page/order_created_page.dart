import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../chat_page/chat_page.dart';

class OrderCreatedPage extends StatefulWidget {
  Customer customer;
  Operation operation;

  List bankNumbers;
  List bankEmails;

  OrderCreatedPage(
      this.customer, this.operation, this.bankNumbers, this.bankEmails);

  @override
  State<OrderCreatedPage> createState() => _OrderCreatedPageState();
}

class _OrderCreatedPageState extends State<OrderCreatedPage> {
  late Operation operation;
  List payInfo = [];
  @override
  void initState() {
    super.initState();

    setState(() {
      operation = widget.operation;
    });
    setState(() {
      if (widget.bankNumbers[0].isNotEmpty) {
        payInfo = widget.bankNumbers;
      } else {
        payInfo = widget.bankEmails;
      }
    });
  }

  bool pressed = false;
  final _walletController = TextEditingController();
  final _emailAddressController = TextEditingController();
  Widget WalletCashNumber() {
    String? validateText;
    String? validation() {
      String number = _walletController.text;
      if ((number.isEmpty || number.trim().isEmpty) && pressed) {
        setState(() {
          validateText = 'Empty field!';
        });
      } else if ((number.length != 11) && pressed) {
        setState(() {
          validateText = 'Wrong number!';
        });
      } else {
        setState(() {
          validateText = null;
        });
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(operation.receiveBank.URL),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _walletController,
                  scrollPadding: EdgeInsets.only(bottom: 200),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff004d60),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    errorText: validation(),
                    hintText: 'Enter Your Wallet Cash Number',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        validateText != null
            ? Container(
                height: 20,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  validateText!,
                  style: TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              )
            : SizedBox(
                height: 20,
              ),
      ],
    );
  }

  Widget AccountAddress(String bankName, bool isEmail) {
    String? validateText;
    String? validation() {
      var text = _emailAddressController.text;
      if ((text.isEmpty || text.trim().isEmpty) && pressed) {
        setState(() {
          validateText = "Empty field!";
        });
      } else if (text.isNotEmpty &&
          !EmailValidator.validate(text) &&
          pressed &&
          isEmail) {
        setState(() {
          validateText = "Wrong email!";
        });
      } else {
        setState(() {
          validateText = null;
        });
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(operation.receiveBank.URL),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  scrollPadding: EdgeInsets.only(bottom: 200),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailAddressController,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff004d60),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    errorText: validation(),
                    hintText: 'Enter Your $bankName account',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        validateText != null
            ? Container(
                height: 20,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  validateText!,
                  style: TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              )
            : SizedBox(
                height: 20,
              ),
      ],
    );
  }

  Widget EnterUserInfo() {
    if (widget.bankNumbers[0].isNotEmpty) {
      return WalletCashNumber();
    } else {
      return AccountAddress(operation.receiveBank.bankName, false);
    }
  }

  FirebaseServices fireServ = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Order Created",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                // Row(
                //   children: [
                //     Text('Pay the sender within'),
                //     Text(
                //       '14:53',
                //       style: TextStyle(color: Colors.orange),
                //     ),
                //   ],
                // ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                // borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EnterUserInfo(),
                                  Text(
                                    'Pay the money to : ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: payInfo.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: Colors.grey.shade200,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            padding: EdgeInsets.all(10),
                                            height: 50,
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      operation.sendBank.URL),
                                                ),
                                                Spacer(),
                                                Text(
                                                  payInfo[index].toString(),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                          index % 2 != 0
                                              ? Text(
                                                  'OR',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                )
                                              : SizedBox(),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatScreen(widget.customer, operation),
                                ));
                          },
                          child: Text(
                            'Chat page',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Send Amount',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      '${operation.sendAmount.toStringAsFixed(2)}  ${operation.sendBank.currency}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Receive Amount',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      '${operation.receiveAmount.toStringAsFixed(2)}  ${operation.receiveBank.currency}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price  ',
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                    Text(
                                      '${operation.price}  ${operation.receiveBank.currency}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'OrderNumber ',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        '${operation.operationId}',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ]),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 130,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  fireServ.cancelOperation(
                                      operation, widget.customer);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed = true;
                                  });
                                  // fireServ.changeTheStateOfOperation(
                                  //     operation,
                                  //     widget.customer,
                                  //     StateOfOperation.Paid_Pending);
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'I send the money',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
