import 'package:cloud_firestore/cloud_firestore.dart';

import '../bank/bank.dart';

class Transition {
  double price;
  double lowerLimit;
  double upperLimit;
  Bank sendBank;
  Bank receivedBank;
  List bankNumbers;
  List bankEmails;

  Transition(
      {required this.price,
      required this.lowerLimit,
      required this.upperLimit,
      required this.sendBank,
      required this.receivedBank,
      required this.bankNumbers,
      required this.bankEmails});

  factory Transition.fromSnapshot(QueryDocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    String id = document.id;
    double price = double.parse(data['price'].toString());
    double lowerLimit = double.parse(data['lowerLimit'].toString());
    double upperLimit = double.parse(data['upperLimit'].toString());
    Bank? sendBank = Bank.getBankInfo(data['sendBank']);
    Bank? receivedBank = Bank.getBankInfo(data['receivedBank']);
    List? bankNumbers = data['bankEmails'];
    List? bankEmails = data['bankNumbers'];

    return Transition(
        price: price,
        lowerLimit: lowerLimit,
        upperLimit: upperLimit,
        sendBank: sendBank!,
        receivedBank: receivedBank!,
        bankNumbers: bankNumbers!,
        bankEmails: bankEmails!);
  }

  static Transition? getTransitionInfo(Bank sendBank, Bank receivedBank) {
    Transition? bankInfo;
    for (Transition bI in transitionInfoList) {
      if (bI.sendBank.bankName == sendBank.bankName &&
          bI.receivedBank.bankName == receivedBank.bankName) {
        return bI;
      }
    }
    return bankInfo;
  }

  static Future<void> settingTransitionInfoList() async {
    // await BankInfo.settingBankInfoList();
    CollectionReference reference = FirebaseFirestore.instance
        .collection('System')
        .doc('TransitionInfo')
        .collection('Transition');
    final snapshot = await reference.get();
    final list = snapshot.docs.map((e) => Transition.fromSnapshot(e)).toList();
    transitionInfoList.clear();
    transitionInfoList = list;
  }

  static List<Transition> transitionInfoList = [];
}
