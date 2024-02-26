import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';
import '../enumes/enums.dart';
import 'bank/bank.dart';
import 'operation/operation.dart';

enum StateOfOperation {
  Unpaid_Pending,
  Paid_Pending,
  Canceled_Completed,
  Completed_Completed
}

enum StateOfInternet { online, offline }

enum StateOfFeedback { positive, negative }

class Trade {
  Customer customer;
  late final operationId;

  Trade(this.customer) {
    var uuid = Uuid();
    operationId = uuid.v1().substring(0, 13);
  }

  Operation makeATrade(Bank sendBank, Bank receiveBank, double sendAmount,
      double receiveAmount, double price) {
    DateTime dataOfBegin = DateTime.now();
    Operation operationCustomer =
        // sendBank,
        // receivedBank,
        Operation(
            customer: customer,
            operationId: operationId,
            stateOfOperation: StateOfOperation.Unpaid_Pending,
            price: price,
            sendAmount: sendAmount,
            receiveAmount: receiveAmount,
            sendBank: sendBank,
            receiveBank: receiveBank,
            dataOfBegin: dataOfBegin,
            dataOfEnd: dataOfBegin);

    Operation operationTrader = Operation(
        customer: customer,
        operationId: operationId,
        stateOfOperation: StateOfOperation.Unpaid_Pending,
        price: price,
        sendAmount: sendAmount,
        receiveAmount: receiveAmount,
        sendBank: receiveBank,
        receiveBank: sendBank,
        dataOfBegin: dataOfBegin,
        dataOfEnd: dataOfBegin);
    customer.operations.add(operationCustomer);
    return operationCustomer;
  }

  // void changeTheState(StateOfOperation stateOfOperation) {
  //   DateTime dataOfEnd = DateTime.now();
  //
  //   for (Operation operation in customer.operations) {
  //     if (operation.operationId == operationId) {
  //       operation.stateOfOperation = stateOfOperation;
  //       operation.dataOfEnd = dataOfEnd;
  //     }
  //   }
  // }

  @override
  String toString() {
    return 'Trade{customer: ${customer.name}, operationId: $operationId}';
  }
}

class FirebaseServices {
  void addOperationInDB(Operation operation, Customer customer) async {
    // add operation to DB (CurrentOperations && Users)

    await FirebaseFirestore.instance
        .collection('CurrentOperations')
        .doc(operation.operationId)
        .set({
      'operationId': operation.operationId,
      'CustomerEmail': operation.customer.email,
      // 'StateOfOperation': operation.stateOfOperation.name,
      // 'SendBankName': operation.sendBank.bankName,
      // 'SendBankCurrency': operation.sendBank.currency,
      // 'ReceiveBankName': operation.receiveBank.bankName,
      // 'ReceiveCurrency': operation.receiveBank.currency,
      // 'Price': operation.price,
      // 'SendAmount': operation.sendAmount,
      // 'ReceiveAmount': operation.receiveAmount,
      // 'DataOfBegin': operation.dataOfBegin,
      // 'DataOfEnd': operation.dataOfEnd,
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(customer.email)
        .collection('Operations')
        .doc(operation.operationId)
        .set({
      'operationId': operation.operationId,
      'CustomerEmail': operation.customer.email,
      'CustomerAccount': null,
      'StateOfOperation': operation.stateOfOperation.name,
      'SendBankName': operation.sendBank.bankName,
      'SendBankCurrency': operation.sendBank.currency,
      'ReceiveBankName': operation.receiveBank.bankName,
      'ReceiveCurrency': operation.receiveBank.currency,
      'Price': operation.price,
      'SendAmount': operation.sendAmount,
      'ReceiveAmount': operation.receiveAmount,
      'DataOfBegin': operation.dataOfBegin,
      'DataOfEnd': operation.dataOfEnd,
    });
  }

  void cancelOperation(Operation operation, Customer customer) async {
    DateTime dataOfEnd = DateTime.now();

    await FirebaseFirestore.instance
        .collection('CurrentOperations')
        .doc(operation.operationId)
        .delete();

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(customer.email)
        .collection('Operations')
        .doc(operation.operationId)
        .update({
      'DataOfEnd': dataOfEnd,
      'StateOfOperation': StateOfOperation.Canceled_Completed.name,
    });
  }

  void changeTheStateOfOperation(
      Operation operation,
      Customer customer,
      StateOfOperation stateOfOperation,
      String? customerAccount,
      bool isChatButton) async {
    DateTime dataOfEnd = DateTime.now();

    // await FirebaseFirestore.instance
    //     .collection('CurrentOperations')
    //     .doc(operation.operationId)
    //     .update({
    //   'DataOfEnd': dataOfEnd,
    //   'StateOfOperation': stateOfOperation.name,
    // });

    if (!isChatButton) {
      if (customerAccount != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(customer.email)
            .collection('Operations')
            .doc(operation.operationId)
            .update({
          'CustomerAccount': customerAccount,
          'DataOfEnd': dataOfEnd,
          'StateOfOperation': stateOfOperation.name,
        });
      } else {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(customer.email)
            .collection('Operations')
            .doc(operation.operationId)
            .update({
          'DataOfEnd': dataOfEnd,
          'StateOfOperation': stateOfOperation.name,
        });
      }
    } else {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(customer.email)
          .collection('Operations')
          .doc(operation.operationId)
          .update({
        'CustomerAccount': customerAccount,
      });
    }
  }
}

class Customer {
  List<Operation> operations;
  List<Feedback> feedbacks;
  StateOfInternet stateOfInternet;
  String name;
  String email;

  Customer(this.operations, this.feedbacks, this.name, this.email,
      this.stateOfInternet);

  @override
  String toString() {
    return 'Customer{operations: $operations, feedbacks: $feedbacks, stateOfInternet: ${stateOfInternet.name}, name: $name, email: $email}';
  }
}

class Feedback {
  Customer customer;
  Operation operation;
  StateOfFeedback stateOfFeedback;
  String? theText;
  DateTime data;

  Feedback(this.customer, this.operation, this.stateOfFeedback, this.theText,
      this.data);
}
