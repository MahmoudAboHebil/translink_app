import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../enumes/enums.dart';
import '../../models/bank/bank.dart';

class SelectBankButton extends StatefulWidget {
  SelectBankButton(
      {required this.typeOfTrade,
      required this.callbackUpdateField,
      required this.list,
      required this.initialValue,
      required this.otherValue,
      required this.callback});

  final TypeOfTrade typeOfTrade;
  final List<Bank> list;
  final Bank initialValue;
  Bank? otherValue;

  final Function callback;
  final Function callbackUpdateField;
  @override
  State<SelectBankButton> createState() => _SelectBankButtonState();
}

class _SelectBankButtonState extends State<SelectBankButton> {
  String selectedValue = '';
  List<String> itemsAsString = [];
  int index = 0;
  Bank? bankInfoSelected;

  @override
  void initState() {
    super.initState();
    setState(() {
      itemsAsString = [];
      index = widget.list.indexOf(widget.initialValue);
      selectedValue = widget.initialValue.toString();

      for (Bank val in widget.list) {
        itemsAsString.add(val.toString());
        if (selectedValue == val.toString()) {
          bankInfoSelected = val;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      itemsAsString = [];
      for (Bank val in widget.list) {
        itemsAsString.add(val.toString());
      }
    });
    if (widget.otherValue != null &&
        widget.typeOfTrade == TypeOfTrade.Receive) {
      selectedValue = widget.otherValue.toString();
    }
    for (Bank bI in widget.list) {
      if (selectedValue == bI.toString()) {
        bankInfoSelected = bI;
      }
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        menuItemStyleData: MenuItemStyleData(),
        onMenuStateChange: (value) {},
        buttonStyleData: ButtonStyleData(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        customButton: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.typeOfTrade == TypeOfTrade.Send
                  ? Container(
                      width: double.infinity,
                      child: Text(
                        'Send Bank',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      child: Text(
                        'Receive Bank',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(bankInfoSelected!.URL),
                        ),
                        Text(
                          selectedValue,
                          style: TextStyle(
                              fontSize: 18,
                              color: widget.typeOfTrade == TypeOfTrade.Send
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: widget.typeOfTrade == TypeOfTrade.Send
                              ? Colors.white
                              : Colors.black,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        items: itemsAsString.map((item) {
          Bank? bankInfo;
          for (Bank bI in widget.list) {
            if (bI.toString() == item) {
              bankInfo = bI;
            }
          }

          return DropdownMenuItem<String>(
            value: item,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border:
                      itemsAsString.indexOf(item) == itemsAsString.length - 1
                          ? null
                          : Border(
                              bottom: BorderSide(
                                  color: widget.typeOfTrade == TypeOfTrade.Send
                                      ? Colors.white
                                      : Colors.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(bankInfo!.URL),
                  ),
                  Text(
                    item,
                    style: TextStyle(
                        fontSize: 16,
                        color: widget.typeOfTrade == TypeOfTrade.Send
                            ? Colors.white
                            : Colors.black),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            widget.otherValue = null;
            selectedValue = value as String;
            index = itemsAsString.indexOf(selectedValue);
            widget.callback(widget.list[index]);
          });
          widget.callbackUpdateField();
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          padding: null,
          elevation: 0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: widget.typeOfTrade == TypeOfTrade.Send
                  ? Color(0xff7d53f3)
                  : Color(0xffe7e1f9)),
          offset: const Offset(0, 5),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(0),
            thumbVisibility: MaterialStateProperty.all(false),
          ),
        ),
      ),
    );
  }
}
