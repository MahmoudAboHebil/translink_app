import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerUI extends StatefulWidget {
  const DrawerUI({super.key});

  @override
  State<DrawerUI> createState() => _DrawerUIState();
}

class _DrawerUIState extends State<DrawerUI> {
  String email = '';
  String name = '';
  String imageURL = '';
  String division = '';
  String department = '';
  bool collageOption = false;
  bool departmentOption = false;

  // ScaffoldFeatureController<SnackBar, SnackBarClosedReason> message(
  //     String text) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: Colors.transparent,
  //       // behavior: SnackBarBehavior.floating,
  //       clipBehavior: Clip.none,
  //       elevation: 0,
  //       content: Stack(
  //         alignment: Alignment.center,
  //         clipBehavior: Clip.none,
  //         children: [
  //           Container(
  //             padding: EdgeInsets.all(8),
  //             alignment: Alignment.bottomCenter,
  //             decoration: BoxDecoration(
  //               color: Color(0xff4562a7),
  //               borderRadius: BorderRadius.all(Radius.circular(15)),
  //             ),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 SizedBox(
  //                   width: 48,
  //                 ),
  //                 Expanded(
  //                   child: Text(
  //                     text,
  //                     style: TextStyle(fontSize: 14, color: Colors.white),
  //                     maxLines: 3,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //               bottom: 25,
  //               left: 20,
  //               child: Icon(

  //                 Icons.circle,
  //                 color: Colors.red.shade200,
  //                 size: 17,
  //               )),
  //           Positioned(
  //               top: -20,
  //               left: 5,
  //               child: Stack(
  //                 alignment: Alignment.center,
  //                 clipBehavior: Clip.none,
  //                 children: [
  //                   Container(
  //                     height: 30,
  //                     width: 30,
  //                     decoration: BoxDecoration(
  //                       color: Colors.red,
  //                       borderRadius: BorderRadius.all(Radius.circular(20)),
  //                     ),
  //                   ),
  //                   Icon(

  //                     Icons.clear_outlined,
  //                     color: Colors.white,
  //                     size: 20,
  //                   )
  //                 ],
  //               )),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget headerContent() {
    return 'name'.isEmpty
        ? Center(
            child: Icon(
              FontAwesomeIcons.spinner,
              color: Colors.white,
              size: 40,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Text(
                  'M',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                radius: 25,
                backgroundColor: Color(0xff4b00b8),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mahmoud',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'mahmoud@gmail.com',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff2e0073),
          Color(0xff4b00b8),
        ])),
        child: Column(
          children: [
            //####################  top  content ##################
            Container(
              padding: EdgeInsets.only(top: 20, right: 20, left: 20),
              width: double.infinity,
              color: Colors.transparent,
              height: 125,
              child: headerContent(),
            ),

            //####################  center content ##################
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(
                        size: 20,
                        Icons.person,
                        color: Color(0xff2e0073),
                      ),
                      title: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Profile',
                            style: TextStyle(color: Colors.grey.shade800),
                          )),
                    ),
                    ListTile(
                      leading: Icon(
                        size: 20,
                        Icons.history,
                        color: Color(0xff2e0073),
                      ),
                      title: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'History',
                            style: TextStyle(color: Colors.grey.shade800),
                          )),
                    ),
                    ListTile(
                      leading: Icon(
                        size: 20,
                        Icons.language,
                        color: Color(0xff2e0073),
                      ),
                      title: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Language',
                            style: TextStyle(color: Colors.grey.shade800),
                          )),
                    ),
                    ListTile(
                      leading: Icon(
                        size: 20,
                        Icons.mark_unread_chat_alt_outlined,
                        color: Color(0xff2e0073),
                      ),
                      title: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Help',
                            style: TextStyle(color: Colors.grey.shade800),
                          )),
                    ),
                    ListTile(
                      leading: Icon(
                        size: 20,
                        Icons.security,
                        color: Color(0xff2e0073),
                      ),
                      title: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Security',
                            style: TextStyle(color: Colors.grey.shade800),
                          )),
                    ),
                    ListTile(
                      leading: Icon(
                          size: 20,
                          Icons.logout_outlined,
                          color: Color(0xff2e0073)),
                      title: GestureDetector(
                        onTap: () async {
                          //###################
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: 18),
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 18),
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.timesCircle,
                          size: 20, color: Colors.red),
                      title: GestureDetector(
                        onTap: () async {
                          //###################
                        },
                        child: Text(
                          'Close account',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
