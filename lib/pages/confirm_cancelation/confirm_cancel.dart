import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../enumes/enums.dart';
import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../home_page/home_page.dart';
import '../select_method/select_method.dart';

class ConfirmCancel extends StatefulWidget {
  Operation operation;
  Customer customer;

  ConfirmCancel(this.operation, this.customer);

  @override
  State<ConfirmCancel> createState() => _ConfirmCancelState();
}

class _ConfirmCancelState extends State<ConfirmCancel> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectMethod(),
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
                        color: Color(0xffd8dbe0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            padding: EdgeInsets.only(top: 20, left: 10),
                            height: 50,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectMethod(),
                                    ));
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff929aa5),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Canceled',
                                      style: TextStyle(
                                          fontSize: 30, letterSpacing: 1.5),
                                    ),
                                    Text(
                                      'You have cancelled the order',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 40),
                                  child: Icon(
                                    FontAwesomeIcons.exclamationCircle,
                                    color: Color(0xff929aa5),
                                    size: 70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Color(0xfffafafa),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                          )),
                      height: MediaQuery.of(context).size.height - 225,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      '${widget.operation.receiveAmount.toStringAsFixed(2)} ${widget.operation.receiveBank.currency}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        // fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  height: 30,
                                ),
                                Container(
                                  width: 140,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              ],
                            ),
                          ),
                          Spacer(flex: 1),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: ElevatedButton(
                              // color: Color(0xff7d53f3),
                              style: ButtonStyle(
                                  // elevation: MaterialStatePropertyAll(10),
                                  // shadowColor: MaterialStatePropertyAll(Color(0xff7d53f3)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.all(10)),
                                  alignment: Alignment.center,
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xff7d53f3))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                child: Text(
                                  'Back to Home',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          )
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
