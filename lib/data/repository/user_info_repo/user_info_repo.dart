import 'package:translink_app/data/firebase_services/authent.dart';
import 'package:translink_app/data/model/user_Info_model.dart';

import '../../firebase_services/config.dart';

class UserInfoRepo {
  final _authService = FireAuthService();

  Future<UserInfoModel> getUserInfo(String email) async {
    try {
      var userDoc = await _authService.getUserInfoDocument(email);
      var docSnapshot = await userDoc.get();
      UserInfoModel user = UserInfoModel.formSnapshots(docSnapshot);
      return user;
    } catch (e) {
      throw Exception(
          '${e.toString()} ,\n Error in UserInfoRepo class (getUserInfo) method');
    }
  }

  Future<bool> isUserExist(String email) async {
    bool isExist = await _authService.isUserExist(email);
    return isExist;
  }

  void addUserInfo(UserInfoModel userInfo) async {
    try {
      var userDoc = _authService.getUsersInfoCollection();
      userDoc.doc(userInfo.email).set(userInfo.toDocument());
    } catch (e) {
      throw Exception(
          '${e.toString()} ,\n Error in UserInfoRepo class (addUserInfo) method');
    }
  }
}
