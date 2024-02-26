import 'package:flutter/material.dart';

import '../../models/operation/operation.dart';
import '../../models/person.dart';
import 'confirm_cancel.dart';

class ConfirmCancelltion extends StatefulWidget {
  Operation operation;
  Customer customer;

  ConfirmCancelltion(this.operation, this.customer);

  @override
  State<ConfirmCancelltion> createState() => _ConfirmCancelltionState();
}

class _ConfirmCancelltionState extends State<ConfirmCancelltion> {
  bool isChecked = false;
  String? reason;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reason for cancellation',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'I do not want the order ',
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I do not want the order ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Radio(
                        value:
                            'There is technical or network error with the payment platform',
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'There is technical or network error with the payment platform',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Radio(
                        value:
                            'I do not meet the requirements of the advertiser`s trading terms and condition',
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I do not meet the requirements of the advertiser`s trading terms and condition',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'No response from the seller',
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'No response from the seller',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Other reasons',
                        groupValue: reason,
                        onChanged: (value) {
                          setState(() {
                            reason = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Other reasons',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      Text(
                        'I Have not paid to the trader',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: ElevatedButton(
                    // color: Color(0xff7d53f3),
                    style: ButtonStyle(
                        // elevation: MaterialStatePropertyAll(10),
                        // shadowColor: MaterialStatePropertyAll(Color(0xff7d53f3)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                        alignment: Alignment.center,
                        backgroundColor: MaterialStatePropertyAll(isChecked
                            ? Color(0xff7d53f3)
                            : Colors.grey.shade300)),
                    onPressed: () {
                      FirebaseServices fireServ = FirebaseServices();

                      if (isChecked) {
                        fireServ.cancelOperation(
                            widget.operation, widget.customer);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmCancel(
                                  widget.operation, widget.customer),
                            ));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: Text(
                        'Confirm Cancellation',
                        style: TextStyle(
                            color: isChecked ? Colors.white : Colors.black38,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
