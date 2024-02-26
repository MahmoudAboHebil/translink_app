import 'package:flutter/material.dart';

import '../../models/Transition/Transition.dart';
import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../order_canceled/order_canceled.dart';
import '../peinding_processing_page/peinding_processing_page.dart';
import '../send_money/send_money.dart';
import 'components/box_title_animation.dart';
import 'components/operation_card.dart';

class HistoryPage extends StatefulWidget {
  Customer customer;

  HistoryPage(this.customer);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // List<Operation> operationsList = [];
  void getData() async {
    await Operation.settingOperationsList(widget.customer);
    setState(() {
      Operation.operationsList_all;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isPendingHead = true;
  bool isPendingAll = true;
  bool isUnpaid = false;
  bool isPaid = false;
  bool isCompletedHead = false;
  bool isCompletedAll = false;
  bool isCompletedSection = false;
  bool isCanceled = false;
  Widget choosingTitle(bool isPending) {
    if (isPending) {
      return Row(
        children: [
          BoxTitleAnimation(
              title: 'All',
              value: isPendingAll,
              onTap: () {
                setState(() {
                  if (!isPendingAll) {
                    isPendingAll = !isPendingAll;
                    isUnpaid = !isPendingAll;
                    isPaid = !isPendingAll;
                  }
                });
              }),
          SizedBox(
            width: 15,
          ),
          BoxTitleAnimation(
              title: 'Unpaid',
              value: isUnpaid,
              onTap: () {
                setState(() {
                  if (!isUnpaid) {
                    isUnpaid = !isUnpaid;
                    isPendingAll = !isUnpaid;
                    isPaid = !isUnpaid;
                  }
                });
              }),
          SizedBox(
            width: 15,
          ),
          BoxTitleAnimation(
              title: 'Paid',
              value: isPaid,
              onTap: () {
                setState(() {
                  if (!isPaid) {
                    isPaid = !isPaid;
                    isPendingAll = !isPaid;
                    isUnpaid = !isPaid;
                  }
                });
              }),
        ],
      );
    } else {
      return Row(
        children: [
          BoxTitleAnimation(
              title: 'All',
              value: isCompletedAll,
              onTap: () {
                setState(() {
                  if (!isCompletedAll) {
                    isCompletedAll = !isCompletedAll;
                    isCompletedSection = !isCompletedAll;
                    isCanceled = !isCompletedAll;
                  }
                });
              }),
          SizedBox(
            width: 15,
          ),
          BoxTitleAnimation(
              title: 'Completed',
              value: isCompletedSection,
              onTap: () {
                setState(() {
                  if (!isCompletedSection) {
                    isCompletedSection = !isCompletedSection;
                    isCompletedAll = !isCompletedSection;
                    isCanceled = !isCompletedSection;
                  }
                });
              }),
          SizedBox(
            width: 15,
          ),
          BoxTitleAnimation(
              title: 'Canceled',
              value: isCanceled,
              onTap: () {
                setState(() {
                  if (!isCanceled) {
                    isCanceled = !isCanceled;
                    isCompletedSection = !isCanceled;
                    isCompletedAll = !isCanceled;
                  }
                });
              }),
        ],
      );
    }
  }

  Widget content(
    bool isPendingHead,
    bool isPendingAll,
    bool isUnpaid,
    bool isPaid,
    bool isCompletedHead,
    bool isCompletedAll,
    bool isCompletedSection,
    bool isCanceled,
  ) {
    List<Operation> list = [];
    if (isPendingHead) {
      if (isPendingAll) {
        list = Operation.operationsList_pending;
      } else if (isUnpaid) {
        list = Operation.operationsList_pending_unpaid;
      } else if (isPaid) {
        list = Operation.operationsList_pending_paid;
      }
    } else if (isCompletedHead) {
      if (isCompletedAll) {
        list = Operation.operationsList_completed;
      } else if (isCompletedSection) {
        list = Operation.operationsList_completed_completed;
      } else if (isCanceled) {
        list = Operation.operationsList_completed_canceled;
      }
    }
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              String str = list[index].stateOfOperation.name;
              String result = str.substring(0, str.indexOf('_'));
              if (result == 'Canceled') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderCanceledPage(widget.customer, list[index]),
                    ));
              } else if (result == 'Paid') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PendingProcessingPage(
                          list[index], widget.customer, true),
                    ));
              } else if (result == 'Unpaid') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SendMoneyPage(
                          Customer([], [], 'Ahmed', 'Ahmed@gmail.com',
                              StateOfInternet.online),
                          list[index],
                          Transition.getTransitionInfo(list[index].sendBank,
                                  list[index].receiveBank)!
                              .bankNumbers,
                          Transition.getTransitionInfo(list[index].sendBank,
                                  list[index].receiveBank)!
                              .bankEmails),
                    ));
              }
            },
            child: OperationCard(operation: list[index]),
          );
        },
        itemCount: list.length,
      ),
    );
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(flex: 2),
                    Text(
                      'Order History',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    Spacer(flex: 3),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            BoxTitleAnimation(
                                title: 'Pending',
                                value: isPendingHead,
                                onTap: () {
                                  setState(() {
                                    if (!isPendingHead) {
                                      isPendingAll = true;
                                      isUnpaid = false;
                                      isPaid = false;
                                      isPendingHead = !isPendingHead;
                                      isCompletedHead = !isPendingHead;
                                    }
                                  });
                                }),
                            SizedBox(
                              width: 15,
                            ),
                            BoxTitleAnimation(
                                title: 'Completed',
                                value: isCompletedHead,
                                onTap: () {
                                  setState(() {
                                    if (!isCompletedHead) {
                                      isCompletedAll = true;
                                      isCanceled = false;
                                      isCompletedSection = false;
                                      isCompletedHead = !isCompletedHead;
                                      isPendingHead = !isCompletedHead;
                                    }
                                  });
                                }),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: choosingTitle(isPendingHead),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      content(
                          isPendingHead,
                          isPendingAll,
                          isUnpaid,
                          isPaid,
                          isCompletedHead,
                          isCompletedAll,
                          isCompletedSection,
                          isCanceled),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
