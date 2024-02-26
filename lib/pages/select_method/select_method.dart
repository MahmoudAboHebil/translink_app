import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/select_bank_button/select_bank_button.dart';
import '../../enumes/enums.dart';
import '../../models/Transition/Transition.dart';
import '../../models/bank/bank.dart';
import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../../widgets/app_button.dart';
import '../home_page/components/exchange_widget.dart';
import '../home_page/home_page.dart';
import '../order_created_page/order_created_page.dart';
import '../send_money/send_money.dart';

class SelectMethod extends StatefulWidget {
  const SelectMethod({super.key});

  @override
  State<SelectMethod> createState() => _SelectMethodState();
}

class _SelectMethodState extends State<SelectMethod> {
  Bank? sendValueSelected;
  Bank? receiveValueSelected;
  Bank? otherValue;
  List<Bank> revList = [];
  final _sendAmountController = TextEditingController();
  double receiveAmount = 0.0;

  String? validateText;
  String? validation() {
    double lowerAmount =
        Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!
            .lowerLimit;
    double maxAmount =
        Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!
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

  void sendValueSelectedCallBack(Bank sendSelected) {
    setState(() {
      sendValueSelected = sendSelected;
    });
  }

  void receiveValueSelectedCallBack(Bank receiveSelected) {
    setState(() {
      receiveValueSelected = receiveSelected;
    });
  }

  void callBackUpdateField() {
    if (sendValueSelected != null && receiveValueSelected != null) {
      if (sendValueSelected.toString() == receiveValueSelected.toString()) {
        List<String> list = [];
        List<Bank> listRev = [];
        setState(() {
          Bank.settingSendAndReceivedBankList();
          bool val = true;

          for (Transition tI in Transition.transitionInfoList) {
            if (sendValueSelected!.bankName == tI.sendBank.bankName) {
              list.add(tI.receivedBank.toString());
              listRev.add(tI.receivedBank);
            }
          }
          for (Bank value in Bank.receiveBankList) {
            bool isContain = list.contains(value.toString());
            if (value != receiveValueSelected && val && isContain) {
              receiveValueSelected = value;
              otherValue = receiveValueSelected;
              val = false;
            }
          }
        });

        listRev.remove(sendValueSelected);
        revList = listRev;
      } else {
        ///todo: remove non Transition form receiveBankList
        List<Bank> listRev = [];
        bool val = true;
        for (Transition tI in Transition.transitionInfoList) {
          if (sendValueSelected!.bankName == tI.sendBank.bankName) {
            listRev.add(tI.receivedBank);
          }
          if (tI.sendBank.bankName == sendValueSelected!.bankName &&
              tI.receivedBank.bankName == receiveValueSelected!.bankName) {
            val = false;
          }
        }
        listRev.remove(sendValueSelected);
        revList = listRev;
        if (val) {
          setState(() {
            receiveValueSelected = revList[0];
            otherValue = revList[0];
          });
        } else {
          setState(() {
            otherValue = null;
          });
        }
      }
    }

    setState(() {
      sendValueSelected = sendValueSelected;
      receiveValueSelected = receiveValueSelected;
      String value = _sendAmountController.text;
      print("sendValueSelected$sendValueSelected");
      print("receiveValueSelected$receiveValueSelected");
      if (value.isNotEmpty) {
        double price = Transition.getTransitionInfo(
                sendValueSelected!, receiveValueSelected!)!
            .price;

        if (receiveValueSelected!.currency == Currency.USD.name &&
            sendValueSelected!.currency == Currency.EGP.name) {
          receiveAmount = double.parse(value) / price;
        } else if (receiveValueSelected!.currency == Currency.EGP.name &&
            sendValueSelected!.currency == Currency.USD.name) {
          receiveAmount = double.parse(value) * price;
        }
      }
    });
  }

  @override
  void initState() {
    for (Bank bI in Bank.sendBankList) {
      if (bI.bankName == 'PayPal') {
        sendValueSelected = bI;
      }
    }
    for (Bank bI in Bank.receiveBankList) {
      if (bI.bankName == 'VodafoneCash') {
        receiveValueSelected = bI;
      }
    }
    List<Bank> listRev = [];
    bool val = true;
    for (Transition tI in Transition.transitionInfoList) {
      if (sendValueSelected!.bankName == tI.sendBank.bankName) {
        listRev.add(tI.receivedBank);
      }
      if (tI.sendBank.bankName == sendValueSelected!.bankName &&
          tI.receivedBank.bankName == receiveValueSelected!.bankName) {
        val = false;
      }
    }
    listRev.remove(sendValueSelected);
    revList = listRev;
    if (val) {
      setState(() {
        receiveValueSelected = revList[0];
        otherValue = revList[0];
      });
    } else {
      setState(() {
        otherValue = null;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
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
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color(0xff2e0073),
                        Color(0xff4b00b8),
                      ])),
                      child: Column(
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ));
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(flex: 2),
                                Text(
                                  'Select Method',
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
                            padding: EdgeInsets.only(right: 20, left: 20),
                            width: double.infinity,
                            color: Colors.transparent,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffC3C7E5),
                                        width: 0.3,
                                      ),
                                      color: Color(0xff7d53f3),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      SelectBankButton(
                                          typeOfTrade: TypeOfTrade.Send,
                                          callbackUpdateField:
                                              callBackUpdateField,
                                          initialValue: sendValueSelected!,
                                          otherValue: null,
                                          list: Bank.sendBankList,
                                          callback: sendValueSelectedCallBack),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                          )),
                      height: MediaQuery.of(context).size.height - 215,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20, left: 20),
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffC3C7E5),
                                  width: 0.3,
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: Color(0xffe7e1f9)),
                            child: Column(
                              children: [
                                SelectBankButton(
                                    typeOfTrade: TypeOfTrade.Receive,
                                    callbackUpdateField: callBackUpdateField,
                                    initialValue: receiveValueSelected!,
                                    otherValue: otherValue,
                                    list: revList,
                                    callback: receiveValueSelectedCallBack),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20, left: 20),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 5,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff4f73fb),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  '1 USD = ${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.price} EGP',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            // height: 250,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Color(0xffD9D9D9)),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.grey.shade200,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 3, right: 15),
                                        child: Text(
                                          sendValueSelected!.currency,
                                          style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: _sendAmountController,
                                          scrollPadding:
                                              EdgeInsets.only(bottom: 200),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'(^\d{0,30}\.?\d{0,2})'))
                                          ],
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff004d60),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value.isNotEmpty) {
                                                double price = Transition
                                                        .getTransitionInfo(
                                                            sendValueSelected!,
                                                            receiveValueSelected!)!
                                                    .price;
                                                if (receiveValueSelected!
                                                            .currency ==
                                                        Currency.USD.name &&
                                                    sendValueSelected!
                                                            .currency ==
                                                        Currency.EGP.name) {
                                                  receiveAmount =
                                                      double.parse(value) /
                                                          price;
                                                } else if (receiveValueSelected!
                                                            .currency ==
                                                        Currency.EGP.name &&
                                                    sendValueSelected!
                                                            .currency ==
                                                        Currency.USD.name) {
                                                  receiveAmount =
                                                      double.parse(value) *
                                                          price;
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
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color: Colors.transparent)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color: Colors.transparent)),
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
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 12),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 20,
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Column(
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
                                          _sendAmountController.text.isNotEmpty
                                              ? Text(
                                                  '${_sendAmountController.text} ${sendValueSelected!.currency}',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                  ),
                                                )
                                              : Text(
                                                  '- - ${sendValueSelected!.currency}',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Receive Amount',
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 15),
                                          ),
                                          _sendAmountController.text.isNotEmpty
                                              ? Text(
                                                  '${receiveAmount.toStringAsFixed(2)} ${receiveValueSelected!.currency}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text(
                                                  '- - ${receiveValueSelected!.currency}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(right: 20, left: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Color(0xffD9D9D9)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price   ',
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    '${Currency.USD.name} ',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.price}',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Limit',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.sendBank.currency}',
                                    style:
                                        TextStyle(color: Colors.grey.shade900),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.lowerLimit}',
                                    style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 0),
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                          color: Colors.grey.shade900,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.sendBank.currency}',
                                    style:
                                        TextStyle(color: Colors.grey.shade900),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.upperLimit}',
                                    style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment Method',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 13,
                                  ),
                                  Text(
                                    '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.receivedBank.bankName}',
                                    style:
                                        TextStyle(color: Colors.grey.shade900),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                          // SizedBox(height: 110),
                          Spacer(),
                          AppButton(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            text: 'Continue',
                            circle: 15,
                            onPressed: () {
                              if (validateText == null &&
                                  _sendAmountController.text.isNotEmpty) {
                                //Data related by Customer
                                Trade trade = Trade(Customer([], [], 'Ahmed',
                                    'Ahmed@gmail.com', StateOfInternet.online));
                                Operation operation = trade.makeATrade(
                                    sendValueSelected!,
                                    receiveValueSelected!,
                                    double.parse(_sendAmountController.text),
                                    receiveAmount,
                                    Transition.getTransitionInfo(
                                            sendValueSelected!,
                                            receiveValueSelected!)!
                                        .price);

                                ///todo: add operation to DB (CurrentOperations && Users)
                                FirebaseServices fireServ = FirebaseServices();
                                fireServ.addOperationInDB(
                                    operation,
                                    Customer([], [], 'Ahmed', 'Ahmed@gmail.com',
                                        StateOfInternet.online));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SendMoneyPage(
                                          Customer([], [],
                                              'Ahmed',
                                              'Ahmed@gmail.com',
                                              StateOfInternet.online),
                                          operation,
                                          Transition.getTransitionInfo(
                                                  sendValueSelected!,
                                                  receiveValueSelected!)!
                                              .bankNumbers,
                                          Transition.getTransitionInfo(
                                                  sendValueSelected!,
                                                  receiveValueSelected!)!
                                              .bankEmails),
                                    ));
                              }
                            },
                            backgroundColor: Color(0xff7d53f3),
                            textColor: Colors.white,
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
