import 'package:bloc/bloc.dart';
import 'package:translink_app/data/model/user_Info_model.dart';
import 'package:translink_app/data/repository/user_info_repo/user_info_repo.dart';
import 'package:translink_app/logic/bloc_user_info/bloc_user_info_event.dart';

import 'bloc_user_info_state.dart';

class BlocUserInfo extends Bloc<BlocUserInfoEvent, BlocUserInfoState> {
  final UserInfoRepo userInfoRepo;
  BlocUserInfo({required this.userInfoRepo}) : super(LoadingUserInfo()) {
    on<UserInfoLoading>((event, emit) {
      emit(LoadingUserInfo());
    });
    on<UserInfoLoad>((event, emit) async {
      try {
        emit(LoadingUserInfo());
        UserInfoModel userInfoModel =
            await userInfoRepo.getUserInfo(event.userName);
        emit(LoadedUserInfo(userInfo: userInfoModel));
      } catch (e) {
        emit(ErrorUserInfo(massage: e.toString()));
      }
    });
  }
}
