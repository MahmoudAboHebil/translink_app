import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel {
  final bool pinCode;
  final String email;
  final String userName;
  final String firstName;
  final String lastName;
  final DateTime createdTime;
  UserInfoModel({
    required this.pinCode,
    required this.email,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.createdTime,
  });

  factory UserInfoModel.formSnapshots(DocumentSnapshot snap) {
    return UserInfoModel(
        pinCode: snap['pinCode'],
        email: snap['email'],
        userName: snap['userName'],
        firstName: snap['firstName'],
        lastName: snap['lastName'],
        createdTime: snap['createdTime']);
  }
  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'pinCode': pinCode,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'createdTime': createdTime,
    };
  }
}
