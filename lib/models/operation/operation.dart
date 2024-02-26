import 'package:cloud_firestore/cloud_firestore.dart';

import '../bank/bank.dart';
import '../person.dart';

class Operation {
  Customer customer;
  String operationId;
  String? customerAccount;
  StateOfOperation stateOfOperation;
  double price;
  double sendAmount;
  double receiveAmount;
  Bank sendBank;
  Bank receiveBank;
  DateTime dataOfBegin;
  DateTime dataOfEnd;

  Operation(
      {required this.customer,
      required this.operationId,
      required this.stateOfOperation,
      required this.price,
      required this.sendAmount,
      required this.receiveAmount,
      required this.sendBank,
      required this.receiveBank,
      required this.dataOfBegin,
      required this.dataOfEnd,
      this.customerAccount});

  @override
  String toString() {
    return 'Operation{customer: $customer, operationId: $operationId, stateOfOperation: $stateOfOperation, price: $price, sendAmount: $sendAmount, receiveAmount: $receiveAmount, sendBank: $sendBank, receiveBank: $receiveBank, dataOfBegin: $dataOfBegin, dataOfEnd: $dataOfEnd}';
  }

  factory Operation.fromSnapshot(
      QueryDocumentSnapshot document, Customer customer) {
    final data = document.data() as Map<String, dynamic>;
    DateTime dataOfBegin = (data['DataOfBegin'] as Timestamp).toDate();
    DateTime dataOfEnd = (data['DataOfEnd'] as Timestamp).toDate();

    double price = data['Price'];
    String operationId = data['operationId'];
    String customerAccount = data['CustomerAccount'];
    double receiveAmount = data['ReceiveAmount'];
    Bank receiveBank = Bank.getBankInfo(data['ReceiveBankName'])!;
    Bank sendBank = Bank.getBankInfo(data['SendBankName'])!;
    double sendAmount = data['SendAmount'];
    StateOfOperation? stateOfOperation;
    for (StateOfOperation stp in StateOfOperation.values) {
      if (stp.name == data['StateOfOperation']) {
        stateOfOperation = stp;
      }
    }

    return Operation(
      customer: customer,
      operationId: operationId,
      stateOfOperation: stateOfOperation!,
      price: price,
      sendAmount: sendAmount,
      receiveAmount: receiveAmount,
      sendBank: sendBank,
      receiveBank: receiveBank,
      dataOfBegin: dataOfBegin,
      dataOfEnd: dataOfEnd,
      customerAccount: customerAccount,
    );
  }

  static Future<void> settingOperationsList(Customer customer) async {
    // await BankInfo.settingBankInfoList();
    operationsList_all.clear();
    operationsList_pending.clear();
    operationsList_pending_paid.clear();
    operationsList_pending_unpaid.clear();
    operationsList_completed.clear();
    operationsList_completed_canceled.clear();
    operationsList_completed_completed.clear();
    CollectionReference reference = FirebaseFirestore.instance
        .collection('Users')
        .doc(customer.email)
        .collection('Operations');
    final snapshot = await reference.get();
    final list =
        snapshot.docs.map((e) => Operation.fromSnapshot(e, customer)).toList();
    operationsList_all = list;
    operationsList_all.sort((a, b) => b.dataOfEnd.compareTo(a.dataOfEnd));

    for (Operation op in operationsList_all) {
      String str = op.stateOfOperation.name;
      String result = str.substring(str.indexOf('_') + 1);
      if (result == 'Pending') {
        String str = op.stateOfOperation.name;
        String result = str.substring(0, str.indexOf('_'));
        operationsList_pending.add(op);
        if (result == 'Unpaid') {
          operationsList_pending_unpaid.add(op);
        } else {
          operationsList_pending_paid.add(op);
        }
      }
      if (result == 'Completed') {
        String str = op.stateOfOperation.name;
        String result = str.substring(0, str.indexOf('_'));
        operationsList_completed.add(op);
        if (result == 'Canceled') {
          operationsList_completed_canceled.add(op);
        } else {
          operationsList_completed_completed.add(op);
        }
      }
    }
    operationsList_pending.sort((a, b) => b.dataOfEnd.compareTo(a.dataOfEnd));
    operationsList_completed.sort((a, b) => b.dataOfEnd.compareTo(a.dataOfEnd));
    operationsList_pending_paid
        .sort((a, b) => b.dataOfEnd.compareTo(a.dataOfEnd));
    operationsList_pending_unpaid
        .sort((a, b) => b.dataOfEnd.compareTo(a.dataOfEnd));
    operationsList_completed_completed
        .sort((a, b) => b.dataOfEnd.compareTo(a.dataOfEnd));
    operationsList_completed_canceled
        .sort((a, b) => b.dataOfEnd.compareTo(a.dataOfEnd));
  }

  static List<Operation> operationsList_all = [];
  static List<Operation> operationsList_pending = [];
  static List<Operation> operationsList_pending_unpaid = [];
  static List<Operation> operationsList_pending_paid = [];

  static List<Operation> operationsList_completed = [];
  static List<Operation> operationsList_completed_completed = [];
  static List<Operation> operationsList_completed_canceled = [];
}
