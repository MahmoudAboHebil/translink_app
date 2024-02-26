import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../components/bottomAppBar/curved_navigation_bar.dart';
import '../../components/drawer/DrawerUI.dart';
import '../../components/select_bank_button/select_bank_button.dart';
import '../../enumes/enums.dart';
import '../../models/Transition/Transition.dart';
import '../../models/bank/bank.dart';
import '../../models/operation/operation.dart';
import '../../models/person.dart';
import '../history_page/history_page.dart';
import '../select_method/select_method.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showProgress = false;

  late Customer ahmed;
  // late Trader mahmoud;

  @override
  void initState() {
    super.initState();
    setState(() {
      ahmed =
          Customer([], [], 'Ahmed', 'Ahmed@gmail.com', StateOfInternet.online);
      // mahmoud = Trader(
      //     [], [], 'Mahmoud', 'Mahmoud@gmail.com', StateOfInternet.online);
    });
    setData(ahmed);
  }

  void setData(Customer customer) async {
    setState(() {
      showProgress = true;
    });
    await Bank.settingBankInfoList();
    await Transition.settingTransitionInfoList();
    await Bank.settingSendAndReceivedBankList();
    await Operation.settingOperationsList(customer);

    // sendValueSelected = BankInfo.sendBankList[0];
    // receiveValueSelected = BankInfo.sendBankList[1];

    // print('hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    // final ref =
    //     FirebaseStorage.instance.ref().child('bankImages').child('Payeer.jpeg');
    // print(await ref.getDownloadURL());
    // print('hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    //
    // print(Operation.operationsList.length);
    setState(() {
      showProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: DrawerUI(),

          // resizeToAvoidBottomInset: false,

          body: ModalProgressHUD(
            inAsyncCall: showProgress,
            child: !showProgress
                ? Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color(0xff2e0073),
                      Color(0xff4b00b8),
                    ])),
                    child: SafeArea(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ListView(
                            shrinkWrap: true,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 20, right: 20, left: 20),
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    height: 100,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'welcome ',
                                                    style: TextStyle(
                                                        color: Colors.white54,
                                                        fontSize: 15),
                                                  ),
                                                  Text('Robin Mathuls',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    child: Icon(
                                                      Icons.notifications_sharp,
                                                      color: Colors.white,
                                                      size: 22,
                                                    ),
                                                    radius: 22,
                                                    backgroundColor:
                                                        // Color(0xff2e0073),
                                                        Color(0xff4b00b8),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                    height: 45,
                                                    child: Builder(
                                                        builder: (context) {
                                                      return IconButton(
                                                        onPressed: () {
                                                          Scaffold.of(context)
                                                              .openEndDrawer();
                                                        },
                                                        icon: Icon(
                                                          FontAwesomeIcons.bars,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      );
                                                    }),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        // Container(
                                        //   height: 100,
                                        //   margin: EdgeInsets.only(top: 10),
                                        //   decoration: BoxDecoration(
                                        //       color: Color(0xff7d53f3),
                                        //       borderRadius: BorderRadius.only(
                                        //           topLeft: Radius.circular(15),
                                        //           topRight: Radius.circular(15))),
                                        //   child: Column(
                                        //     children: [
                                        //       SelectBankButton(
                                        //           typeOfTrade: TypeOfTrade.Send,
                                        //           initialValue: sendValueSelected!,
                                        //           otherValue: null,
                                        //           list: Bank.sendBankList,
                                        //           callback:
                                        //               sendValueSelectedCallBack),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minHeight: 745,
                                        minWidth: double.infinity,
                                        maxHeight: double.infinity),
                                    padding: EdgeInsets.only(
                                      bottom: 80,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 20, left: 20),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            'Our Reserve',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 120,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: List.generate(
                                                Bank.bankInfoList.length,
                                                (index) {
                                              return Container(
                                                height: 120,
                                                width: 200,
                                                margin: index ==
                                                        Bank.bankInfoList
                                                                .length -
                                                            1
                                                    ? EdgeInsets.only(
                                                        left: 20, right: 20)
                                                    : EdgeInsets.only(left: 20),
                                                padding: EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(Bank
                                                              .bankInfoList[
                                                                  index]
                                                              .URL),
                                                      radius: 18,
                                                    ),
                                                    Text(
                                                      Bank.bankInfoList[index]
                                                          .bankName,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${Bank.bankInfoList[index].reserve} ${Bank.bankInfoList[index].currency}',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 20, left: 20),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Reviews',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Reviews',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 20, left: 20),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Latest Exchanges',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '112/25/2023 10:34',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_circle_right_outlined,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '112/25/2023 10:34',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_circle_right_outlined,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '112/25/2023 10:34',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_circle_right_outlined,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '112/25/2023 10:34',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_circle_right_outlined,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '112/25/2023 10:34',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_circle_right_outlined,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '112/25/2023 10:34',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_circle_right_outlined,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(Bank
                                                                      .sendBankList[
                                                                          0]
                                                                      .URL),
                                                              radius: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '500 EGP',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CurvedNavigationBar(
                            mainButtonFunction: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectMethod(),
                                  ));
                            },
                            height: 60,
                            backgroundColor: Colors.transparent,
                            color: Color(0xfff8f9fb),
                            buttonBackgroundColor: Colors.transparent,
                            animationDuration: Duration(milliseconds: 300),
                            items: widgets,
                            onTap: (index) {
                              print('object$index');
                              setState(() {
                                for (int i = 0; i < widgets.length; i++) {
                                  if (i != index) {
                                    widgets[i] = Icon(
                                      icons[i],
                                      color: Colors.grey,
                                      size: 23,
                                    );
                                  }
                                }

                                if (index == 1) {
                                } else {
                                  widgets[index] = Icon(
                                    size: 28,
                                    icons[index],
                                    color: Color(0xff7d53f3),
                                  );
                                }

                                if (index == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HistoryPage(ahmed),
                                      ));
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ),
        ),
      ),
    );
  }

  bool one = false;

  List<IconData> icons = [Icons.home_filled, Icons.add, Icons.history];
  List<Widget> widgets = [
    Icon(
      Icons.home_filled,
      size: 28,
      color: Color(0xff7d53f3),
    ),
    Icon(
      Icons.add,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.history,
      color: Colors.grey,
      size: 23,
    ),
  ];
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// MyAppBar(
// customer: ahmed,
// ),
// SizedBox(
// height: 150,
// ),
// Container(
// // constraints: BoxConstraints(minHeight: 1000),
// decoration: BoxDecoration(
// color: Color(0xffF1F0E8),
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(25),
// topRight: Radius.circular(25),
// ),
// ),
// child: Column(
// children: [
// SelectBankButton(
// typeOfTrade: TypeOfTrade.Send,
// initialValue: sendValueSelected!,
// otherValue: null,
// list: Bank.sendBankList,
// callback: sendValueSelectedCallBack),
// SizedBox(
// height: 15,
// ),
// Container(
// width: 30,
// height: 40,
// decoration: BoxDecoration(
// color: Colors.transparent,
// image: DecorationImage(
// image: AssetImage(
// 'assets/images/up-and-down-arrows.png'))),
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// height: 5,
// width: 5,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// color: Color(0xff4f73fb),
// ),
// ),
// SizedBox(
// width: 6,
// ),
// Text(
// '1 USD = ${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.price} EGP',
// style: TextStyle(
// color: Colors.grey.shade600,
// ),
// )
// ],
// ),
// SizedBox(
// height: 15,
// ),
// SelectBankButton(
// typeOfTrade: TypeOfTrade.Receive,
// initialValue: receiveValueSelected!,
// otherValue: otherValue,
// list: revList,
// callback: receiveValueSelectedCallBack),
// SizedBox(
// height: 10,
// ),
// Container(
// margin: EdgeInsets.symmetric(
// vertical: 0, horizontal: 20),
// padding: EdgeInsets.symmetric(
// horizontal: 15, vertical: 20),
// decoration: BoxDecoration(
// color: Colors.transparent,
// borderRadius:
// BorderRadius.all(Radius.circular(10)),
// border: Border.all(
// color: Colors.grey.shade300,
// width: 1,
// ),
// boxShadow: [
// BoxShadow(
// blurStyle: BlurStyle.outer,
// color: Colors.grey.shade300,
// blurRadius: 3,
// spreadRadius: 0.1)
// ]),
// child:
//
// Column(
// children: [
// Row(
// mainAxisAlignment:
// MainAxisAlignment.start,
// children: [
// Text(
// 'Price   ',
// style: TextStyle(
// color: Colors.grey.shade700),
// ),
// Text(
// '${Currency.USD.name} ',
// style: TextStyle(color: Colors.green),
// ),
// Text(
// '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.price}',
// style: TextStyle(color: Colors.green),
// ),
// ],
// ),
// SizedBox(
// height: 5,
// ),
// Row(
// mainAxisAlignment:
// MainAxisAlignment.start,
// children: [
// Text(
// 'Limit',
// style: TextStyle(
// color: Colors.grey.shade700,
// fontSize: 15),
// ),
// SizedBox(
// width: 10,
// ),
// Text(
// '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.sendBank.currency}',
// style: TextStyle(
// color: Colors.grey.shade900),
// ),
// SizedBox(
// width: 3,
// ),
// Text(
// '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.lowerLimit}',
// style: TextStyle(
// color: Colors.grey.shade900,
// fontSize: 15),
// ),
// Padding(
// padding: EdgeInsets.symmetric(
// horizontal: 5, vertical: 0),
// child: Text(
// '-',
// style: TextStyle(
// color: Colors.grey.shade900,
// fontSize: 15),
// ),
// ),
// Text(
// '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.sendBank.currency}',
// style: TextStyle(
// color: Colors.grey.shade900),
// ),
// SizedBox(
// width: 3,
// ),
// Text(
// '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.upperLimit}',
// style: TextStyle(
// color: Colors.grey.shade900,
// fontSize: 15),
// ),
// ],

// ),
// SizedBox(
// height: 5,
// ),
// Row(
// mainAxisAlignment:
// MainAxisAlignment.start,
// children: [
// Text(
// 'Payment Method',
// style: TextStyle(
// color: Colors.grey.shade700,
// fontSize: 15),
// ),
// SizedBox(
// width: 13,
// ),
// Text(
// '${Transition.getTransitionInfo(sendValueSelected!, receiveValueSelected!)!.receivedBank.bankName}',
// style: TextStyle(
// color: Colors.grey.shade900),
// ),
// ],
// ),
// SizedBox(
// height: 5,
// ),
// ],
// ),
// ),
// ExchangeWidget(sendValueSelected!,
// receiveValueSelected!, ahmed),
// SizedBox(
// height: 0,
// ),
// ],
// ),
// ),
// ],
// )
