import 'package:equatable/equatable.dart';

abstract class BlocUserInfoEvent extends Equatable {}

class UserInfoLoading extends BlocUserInfoEvent {
  @override
  List<Object> get props => [];
}

class UserInfoLoad extends BlocUserInfoEvent {
  final String userName;
  UserInfoLoad({required this.userName});
  @override
  List<Object> get props => [userName];
}
