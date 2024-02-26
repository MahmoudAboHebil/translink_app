import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../enumes/enums.dart';
import '../../../models/operation/operation.dart';

class OperationCard extends StatelessWidget {
  OperationCard({
    required this.operation,
    super.key,
  });
  Operation operation;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    DateFormat().add_yMd().add_jm().format(operation.dataOfEnd),
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    operation.stateOfOperation.name.substring(
                        0, operation.stateOfOperation.name.indexOf('_')),
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(operation.sendBank.URL),
                    radius: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        operation.sendAmount.toStringAsFixed(2),
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Text(
                        ' ${operation.sendBank.currency}',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.grey,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(operation.receiveBank.URL),
                    radius: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        operation.receiveAmount.toStringAsFixed(2),
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Text(
                        ' ${operation.receiveBank.currency}',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Order   ',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              Text(
                operation.operationId,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
        ],
      ),

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           operation.sendBank.bankName,
      //           style: TextStyle(color: Colors.redAccent),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 20),
      //           child: Icon(Icons.arrow_forward),
      //         ),
      //         Text(
      //           operation.receiveBank.bankName,
      //           style: TextStyle(color: Colors.green),
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),

      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.end,
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'Price   ',
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //                 Text(
      //                   operation.price.toString(),
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //                 Text(
      //                   ' ${Currency.EGP.name}',
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'Amouunt   ',
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //                 Text(
      //                   operation.receiveAmount.toStringAsFixed(2),
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //                 Text(
      //                   ' ${operation.receiveBank.currency}',
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'Order   ',
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //                 Text(
      //                   operation.operationId,
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   operation.stateOfOperation.name.substring(
      //                       0, operation.stateOfOperation.name.indexOf('_')),
      //                   style: TextStyle(color: Colors.grey.shade700),
      //                 ),
      //                 Icon(
      //                   Icons.keyboard_arrow_right_outlined,
      //                   color: Colors.grey,
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   DateFormat()
      //                       .add_yMd()
      //                       .add_jm()
      //                       .format(operation.dataOfEnd),
      //                   style: TextStyle(
      //                       color: Colors.grey.shade500, fontSize: 14),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   operation.sendAmount.toStringAsFixed(2),
      //                   style: TextStyle(color: Colors.black, fontSize: 18),
      //                 ),
      //                 Text(
      //                   ' ${operation.sendBank.currency}',
      //                   style: TextStyle(color: Colors.black, fontSize: 18),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
