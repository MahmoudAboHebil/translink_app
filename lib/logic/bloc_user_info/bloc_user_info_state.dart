import 'package:equatable/equatable.dart';
import 'package:translink_app/data/model/user_Info_model.dart';

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

class ErrorUserInfo extends BlocUserInfoState {
  final String massage;
  ErrorUserInfo({required this.massage});
  @override
  List<Object> get props => [massage];
}
