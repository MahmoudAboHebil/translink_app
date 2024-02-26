import 'package:cloud_firestore/cloud_firestore.dart';

import '../Transition/Transition.dart';

class Bank {
  String URL;
  String bankName;
  String currency;
  int reserve;
  Bank(
      {required this.bankName,
      required this.URL,
      required this.currency,
      required this.reserve});
  @override
  String toString() {
    return '$bankName  $currency';
  }

  factory Bank.fromSnapshot(QueryDocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    return Bank(
      bankName: document.id,
      URL: data['imageURL'],
      currency: data['Currency'],
      reserve: int.parse(data['reserve']),
    );
  }
  static Future<void> settingBankInfoList() async {
    CollectionReference reference = FirebaseFirestore.instance
        .collection('System')
        .doc('BankInfo')
        .collection('Bank');
    final snapshot = await reference.get();
    final list = snapshot.docs.map((e) => Bank.fromSnapshot(e)).toList();
    bankInfoList.clear();
    bankInfoList = list;
  }

  static Bank? getBankInfo(String bank) {
    Bank? bankInfo;
    for (Bank bI in bankInfoList) {
      if (bI.bankName == bank) {
        bankInfo = bI;
      }
    }
    return bankInfo;
  }

  static Future<void> settingSendAndReceivedBankList() async {
    // await TransitionInfo.settingTransitionInfoList();
    sendBankList.clear();
    receiveBankList.clear();
    for (Transition tran in Transition.transitionInfoList) {
      sendBankList.add(tran.sendBank);
    }
    for (Transition tran in Transition.transitionInfoList) {
      receiveBankList.add(tran.receivedBank);
    }
    var set = Set<String>();
    List<Bank> uniquelist =
        sendBankList.where((bI) => set.add(bI.toString())).toList();
    sendBankList = uniquelist;
    var set1 = Set<String>();
    List<Bank> uniquelist1 =
        receiveBankList.where((bI) => set1.add(bI.toString())).toList();
    receiveBankList = uniquelist;
  }

  static List<Bank> bankInfoList = [];
  static List<Bank> sendBankList = [];
  static List<Bank> receiveBankList = [];
}
