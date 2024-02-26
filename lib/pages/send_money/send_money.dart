import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../chat_page/chat_page.dart';
import '../confirm_cancelation/confirm_cancelation.dart';
import '../peinding_processing_page/peinding_processing_page.dart';

class SendMoneyPage extends StatefulWidget {
  Customer customer;
  Operation operation;

  List bankNumbers;
  List bankEmails;

  SendMoneyPage(
      this.customer, this.operation, this.bankNumbers, this.bankEmails);
  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  late Operation operation;
  List payInfo = [];
  bool isOk = false;
  @override
  void initState() {
    super.initState();

    setState(() {
      operation = widget.operation;
    });
    bool isWallet = widget.bankNumbers[0].isNotEmpty;

    setState(() {
      if (widget.bankNumbers[0].isNotEmpty) {
        payInfo = widget.bankNumbers;
        _walletController =
            TextEditingController(text: operation.customerAccount);
      } else {
        payInfo = widget.bankEmails;
        _emailAddressController =
            TextEditingController(text: operation.customerAccount);
      }
    });
  }

  bool pressed = false;
  TextEditingController _walletController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  Widget WalletCashNumber() {
    String? validateText;
    String? validation() {
      String number = _walletController.text;
      if ((number.isEmpty || number.trim().isEmpty) || (number.length != 11)) {
        setState(() {
          isOk = false;
        });
      } else {
        setState(() {
          isOk = true;
        });
      }
      //##############

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
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.normal,
                        fontSize: 18),
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
      if ((text.isEmpty || text.trim().isEmpty) ||
          (text.isNotEmpty && !EmailValidator.validate(text) && isEmail)) {
        setState(() {
          isOk = false;
        });
      } else {
        setState(() {
          isOk = true;
        });
      }
      //###################
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
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        showModalBottomSheet(
          context: context,
          builder: (context) =>
              ConfirmCancelltion(widget.operation, widget.customer),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff2e0073),
            Color(0xff4b00b8),
          ])),
          child: SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(top: 20, left: 10),
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => ConfirmCancelltion(
                                    widget.operation, widget.customer),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(flex: 2),
                          Text(
                            'Send Money',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          Spacer(flex: 3),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 125,
                      // constraints: BoxConstraints(
                      //     minHeight: 745,
                      //     minWidth: double.infinity,
                      //     maxHeight: double.infinity),
                      padding: EdgeInsets.only(right: 20, left: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                // border: Border.all(color: Color(0xffD9D9D9)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    // borderRadius: BorderRadius.circular(10),
                                    // border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      backgroundImage:
                                                          NetworkImage(operation
                                                              .sendBank.URL),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      payInfo[index].toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                              ),
                                              index % 2 != 0
                                                  ? Text(
                                                      'OR',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                      textAlign:
                                                          TextAlign.center,
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
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Color(0xffD9D9D9)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
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
                                  height: 15,
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
                                  height: 15,
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
                                  height: 15,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order Number ',
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
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Color(0xffD9D9D9)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Advertiser`s Terms',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      // padding: EdgeInsets.symmetric(
                                      //     horizontal: 15, vertical: 0),
                                      decoration: BoxDecoration(
                                          border: GradientBoxBorder(
                                            width: 1.5,
                                            gradient: LinearGradient(colors: [
                                              Color(0xffe79aff),
                                              Colors.white
                                            ]),
                                          )
                                          // Border(
                                          //     top: BorderSide(
                                          //         color: Color(0xffe79aff)),
                                          //     bottom: BorderSide(
                                          //         color: Color(0xffe79aff)),
                                          //     left: BorderSide(
                                          //         width: 3,
                                          //         color: Color(0xffe79aff)))
                                          ,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                          gradient: LinearGradient(colors: [
                                            Color(0xfffbeeff),
                                            Colors.white
                                          ])),
                                      child: TextButton(
                                        style: ButtonStyle(
                                            minimumSize:
                                                MaterialStatePropertyAll(
                                                    Size(65, 48)),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(19),
                                                  bottomLeft:
                                                      Radius.circular(19)),
                                            )),
                                            padding: MaterialStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 0))),
                                        onPressed: () {
                                          setState(() {
                                            pressed = true;
                                          });
                                          if (isOk) {
                                            bool isWallet = widget
                                                .bankNumbers[0].isNotEmpty;

                                            fireServ.changeTheStateOfOperation(
                                                operation,
                                                widget.customer,
                                                widget
                                                    .operation.stateOfOperation,
                                                isWallet
                                                    ? _walletController.text
                                                    : _emailAddressController
                                                        .text,
                                                true);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatScreen(
                                                          widget.customer,
                                                          operation),
                                                ));
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              size: 25,
                                              Icons.chat_sharp,
                                              color: Color(0xff7d53f3),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Chat',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'السلام عليكم '
                                  'الدفع ب فودافون كاش فقط لدفع ب فودافون كاش فقط لدفع ب فودافون كاش فقط  ',
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(height: 140),
                          Spacer(),
                          Container(
                            height: 45,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 130,
                                  margin: EdgeInsets.only(right: 10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.all(10)),
                                        alignment: Alignment.center,
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.grey.shade300)),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            ConfirmCancelltion(widget.operation,
                                                widget.customer),
                                      );
                                      // fireServ.cancelOperation(
                                      //     operation, widget.customer);
                                      // Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    // color: Color(0xff7d53f3),
                                    style: ButtonStyle(
                                        // elevation: MaterialStatePropertyAll(10),
                                        // shadowColor: MaterialStatePropertyAll(Color(0xff7d53f3)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.all(10)),
                                        alignment: Alignment.center,
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xff7d53f3))),
                                    onPressed: () {
                                      setState(() {
                                        pressed = true;
                                      });
                                      if (isOk) {
                                        bool isWallet =
                                            widget.bankNumbers[0].isNotEmpty;
                                        setState(() {
                                          operation.customerAccount = isWallet
                                              ? _walletController.text
                                              : _emailAddressController.text;
                                        });

                                        fireServ.changeTheStateOfOperation(
                                            operation,
                                            widget.customer,
                                            StateOfOperation.Paid_Pending,
                                            isWallet
                                                ? _walletController.text
                                                : _emailAddressController.text,
                                            false);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PendingProcessingPage(
                                                      operation,
                                                      widget.customer,
                                                      false),
                                            ));
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.maxFinite,
                                      child: Text(
                                        'Make Payment',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10, vertical: 10),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: 40,
// width: 130,
// alignment: Alignment.center,
// margin: EdgeInsets.only(right: 10),
// decoration: BoxDecoration(
// color: Colors.grey.shade300,
// borderRadius: BorderRadius.circular(5),
// ),
// child: GestureDetector(
// onTap: () {
// fireServ.cancelOperation(
// operation, widget.customer);
// Navigator.pop(context);
// },
// child: Text(
// 'Cancel',
// style: TextStyle(
// color: Colors.black,
// fontWeight: FontWeight.bold),
// ),
// ),
// ),
// Expanded(
// child: GestureDetector(
// onTap: () {
// setState(() {
// pressed = true;
// });
// fireServ.changeTheStateOfOperation(
// operation,
// widget.customer,
// StateOfOperation.Paid_Pending);
// },
// child: Container(
// height: 40,
// decoration: BoxDecoration(
// color: Colors.orangeAccent,
// borderRadius:
// BorderRadius.circular(5),
// ),
// child: Center(
// child: Text(
// 'I send the money',
// style: TextStyle(
// color: Colors.black,
// fontWeight: FontWeight.bold),
// ),
// ),
// ),
// ),
// )
// ],
// ),
// )

//##################
// Container(
//   alignment: Alignment.center,
//   child: GestureDetector(
//     onTap: () {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ChatScreen(
//                 widget.customer, operation),
//           ));
//     },
//     child: Text(
//       'Chat page',
//       style: TextStyle(
//           fontSize: 25,
//           color: Colors.green,
//           fontWeight: FontWeight.bold),
//     ),
//   ),
// ),
