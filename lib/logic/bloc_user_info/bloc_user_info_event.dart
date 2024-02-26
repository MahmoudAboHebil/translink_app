import 'package:equatable/equatable.dart';
import 'package:translink_app/data/model/user_Info_model.dart';

abstract class BlocUserInfoEvent extends Equatable {}

class UserInfoLoading extends BlocUserInfoEvent {
  @override
  List<Object> get props => [];
}

class UserInfoLoad extends BlocUserInfoEvent {
  final String email;
  UserInfoLoad({required this.email});
  @override
  List<Object> get props => [email];
}

class UserInfoAdd extends BlocUserInfoEvent {
  final UserInfoModel userInfoModel;
  UserInfoAdd({required this.userInfoModel});
  @override
  List<Object> get props => [userInfoModel];
}

class UserInfoUpdate extends BlocUserInfoEvent {
  final UserInfoModel currentInfo;
  final bool? pinCode;
  final String email;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final DateTime? createdTime;
  UserInfoUpdate({
    required this.email,
    required this.currentInfo,
    this.pinCode,
    this.userName,
    this.firstName,
    this.lastName,
    this.createdTime,
  });
  @override
  List<Object?> get props =>
      [currentInfo, pinCode, email, userName, firstName, lastName, createdTime];
}

class UserSignUp extends BlocUserInfoEvent {
  final String email;
  final int password;
  UserSignUp({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
