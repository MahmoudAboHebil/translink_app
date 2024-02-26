import 'package:flutter/material.dart';

import '../../models/person.dart';
import '../../pages/history_page/history_page.dart';

class MyAppBar extends StatelessWidget {
  Customer customer;
  MyAppBar({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xffEEE0C9),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryPage(customer),
                  ));
            },
            icon: Icon(
              Icons.file_open,
              color: Color(0xffEEE0C9),
            ),
          ),
        ],
      ),
    );
  }
}
