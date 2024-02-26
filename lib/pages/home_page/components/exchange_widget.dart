import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../enumes/enums.dart';
import '../../../models/Transition/Transition.dart';
import '../../../models/bank/bank.dart';
import '../../../models/operation/operation.dart';
import '../../../models/person.dart';
import '../../order_created_page/order_created_page.dart';

class ExchangeWidget extends StatefulWidget {
  Bank sendValueSelected;
  Bank receiveValueSelected;
  Customer customer;

  ExchangeWidget(
      this.sendValueSelected, this.receiveValueSelected, this.customer);

  @override
  State<ExchangeWidget> createState() => _ExchangeWidgetState();
}

class _ExchangeWidgetState extends State<ExchangeWidget> {
  late Bank sendValueSelected;
  late Bank receiveValueSelected;

  @override
  void initState() {
    super.initState();
    setState(() {
      sendValueSelected = widget.sendValueSelected;
      receiveValueSelected = widget.receiveValueSelected;
    });
  }

  final _sendAmountController = TextEditingController();
  double receiveAmount = 0.0;

  String? validateText;
  String? validation() {
    double lowerAmount =
        Transition.getTransitionInfo(sendValueSelected, receiveValueSelected)!
            .lowerLimit;
    double maxAmount =
        Transition.getTransitionInfo(sendValueSelected, receiveValueSelected)!
            .upperLimit;

    bool save = true;
    double sendAmount = 0;
    try {
      setState(() {
        sendAmount = double.parse(_sendAmountController.text);
        save = true;
      });
    } catch (e) {
      setState(() {
        save = false;
      });
    }
    if (save) {
      if (sendAmount < lowerAmount) {
        setState(() {
          validateText = 'Minimum is $lowerAmount';
        });
      } else if (sendAmount > maxAmount) {
        setState(() {
          validateText = 'Max quantity is $maxAmount';
        });
      } else {
        setState(() {
          validateText = null;
        });
      }
    } else {
      setState(() {
        validateText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (sendValueSelected != widget.sendValueSelected ||
          receiveValueSelected != widget.receiveValueSelected) {
        sendValueSelected = widget.sendValueSelected;
        receiveValueSelected = widget.receiveValueSelected;
        String value = _sendAmountController.text;
        if (value.isNotEmpty) {
          double price = Transition.getTransitionInfo(
                  sendValueSelected, receiveValueSelected)!
              .price;
          if (receiveValueSelected.currency == Currency.USD.name &&
              sendValueSelected.currency == Currency.EGP.name) {
            receiveAmount = double.parse(value) / price;
          } else if (receiveValueSelected.currency == Currency.EGP.name &&
              sendValueSelected.currency == Currency.USD.name) {
            receiveAmount = double.parse(value) * price;
          }
        }
      }
    });
    return Container(
      // height: 250,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            height: 50,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 3, right: 15),
                  child: Text(
                    sendValueSelected.currency,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _sendAmountController,
                    scrollPadding: EdgeInsets.only(bottom: 200),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^\d{0,30}\.?\d{0,2})'))
                    ],
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff004d60),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          double price = Transition.getTransitionInfo(
                                  sendValueSelected, receiveValueSelected)!
                              .price;
                          if (receiveValueSelected.currency ==
                                  Currency.USD.name &&
                              sendValueSelected.currency == Currency.EGP.name) {
                            receiveAmount = double.parse(value) / price;
                          } else if (receiveValueSelected.currency ==
                                  Currency.EGP.name &&
                              sendValueSelected.currency == Currency.USD.name) {
                            receiveAmount = double.parse(value) * price;
                          }
                        }
                      });
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Enter amount',
                      errorText: validation(),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                  child: Text(
                    validateText!,
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                )
              : SizedBox(
                  height: 20,
                ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Send Amount',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    ),
                    _sendAmountController.text.isNotEmpty
                        ? Text(
                            '${_sendAmountController.text} ${sendValueSelected.currency}',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          )
                        : Text(
                            '- - ${sendValueSelected.currency}',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Receive Amount',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    ),
                    _sendAmountController.text.isNotEmpty
                        ? Text(
                            '${receiveAmount.toStringAsFixed(2)} ${receiveValueSelected.currency}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            '- - ${receiveValueSelected.currency}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (validateText == null &&
                        _sendAmountController.text.isNotEmpty) {
                      //Data related by Customer
                      Trade trade = Trade(widget.customer);
                      Operation operation = trade.makeATrade(
                          sendValueSelected,
                          receiveValueSelected,
                          double.parse(_sendAmountController.text),
                          receiveAmount,
                          Transition.getTransitionInfo(
                                  sendValueSelected, receiveValueSelected)!
                              .price);

                      ///todo: add operation to DB (CurrentOperations && Users)
                      FirebaseServices fireServ = FirebaseServices();
                      fireServ.addOperationInDB(operation, widget.customer);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderCreatedPage(
                                widget.customer,
                                operation,
                                Transition.getTransitionInfo(sendValueSelected,
                                        receiveValueSelected)!
                                    .bankNumbers,
                                Transition.getTransitionInfo(sendValueSelected,
                                        receiveValueSelected)!
                                    .bankEmails),
                          ));
                    }
                  },
                  child: Container(
                    color: Colors.green,
                    alignment: Alignment.center,
                    height: 40,
                    width: double.infinity,
                    child: Text(
                      'Exchange now',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
