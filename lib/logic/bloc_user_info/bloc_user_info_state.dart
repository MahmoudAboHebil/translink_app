import 'package:equatable/equatable.dart';
import 'package:translink_app/data/model/user_Info_model.dart';

enum SignUpState {
  weakPassword,
  successfully,
  emailAlreadyExist,
}

abstract class BlocUserInfoState extends Equatable {}

class LoadingUserInfo extends BlocUserInfoState {
  @override
  List<Object> get props => [];
}

class LoadedUserInfo extends BlocUserInfoState {
  final UserInfoModel userInfo;
  LoadedUserInfo({required this.userInfo});
  @override
  List<Object> get props => [userInfo];
}

class AddedUserInfo extends BlocUserInfoState {
  final bool isAdded;
  AddedUserInfo({required this.isAdded});
  @override
  List<Object> get props => [isAdded];
}

class UpdatedUserInfo extends BlocUserInfoState {
  @override
  List<Object> get props => [];
}

class UserSignUp extends BlocUserInfoState {
  final int signUpState;
  UserSignUp({required this.signUpState});
  @override
  List<Object> get props => [signUpState];
}

class ErrorUserInfo extends BlocUserInfoState {
  final String massage;
  ErrorUserInfo({required this.massage});
  @override
  List<Object> get props => [massage];
}
