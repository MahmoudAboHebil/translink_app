import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import '../../enumes/enums.dart';
import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../chat_page/chat_page.dart';
import '../home_page/home_page.dart';
import '../select_method/select_method.dart';

class PendingProcessingPage extends StatefulWidget {
  Operation operation;
  Customer customer;
  bool HistoryPage;

  PendingProcessingPage(this.operation, this.customer, this.HistoryPage);

  @override
  State<PendingProcessingPage> createState() => _PendingProcessingPageState();
}

class _PendingProcessingPageState extends State<PendingProcessingPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.HistoryPage ? true : false,
      onPopInvoked: (didPop) {
        if (!widget.HistoryPage) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectMethod(),
              ));
        }
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
                        color: Colors.transparent,
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
                                if (!widget.HistoryPage) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectMethod(),
                                      ));
                                } else {
                                  Navigator.pop(context);
                                }
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
                                      'Processing',
                                      style: TextStyle(
                                          fontSize: 30,
                                          letterSpacing: 1.5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Transferring takes a few\nminutes',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff929aa5)),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(right: 40),
                                  child: Icon(
                                    FontAwesomeIcons.spinner,
                                    color: Colors.white,
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
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Color(0xffD9D9D9)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Connect with us',
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
                                            widget.operation.stateOfOperation =
                                                StateOfOperation.Paid_Pending;
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatScreen(widget.customer,
                                                        widget.operation),
                                              ));
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
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ref Message',
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
                              ],
                            ),
                          ),
                          Spacer(),
                          !widget.HistoryPage
                              ? Container(
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.all(10)),
                                        alignment: Alignment.center,
                                        backgroundColor:
                                            MaterialStatePropertyAll(
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
                              : SizedBox()
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
