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
            await userInfoRepo.getUserInfo(event.email);
        emit(LoadedUserInfo(userInfo: userInfoModel));
      } catch (e) {
        emit(ErrorUserInfo(massage: e.toString()));
      }
    });
    on<UserInfoAdd>((event, emit) async {
      emit(LoadingUserInfo());
      try {
        await userInfoRepo.addUserInfo(event.userInfoModel);
        emit(AddedUserInfo(isAdded: true));
      } catch (e) {
        emit(AddedUserInfo(isAdded: false));
      }
    });
    on<UserInfoUpdate>((event, emit) async {
      emit(LoadingUserInfo());
      try {
        await userInfoRepo.updateUserInfo(
          event.currentInfo,
          event.pinCode,
          event.email,
          event.userName,
          event.firstName,
          event.lastName,
          event.createdTime,
        );
        emit(UpdatedUserInfo());
      } catch (e) {
        emit(ErrorUserInfo(massage: e.toString()));
      }
    });
  }
}
