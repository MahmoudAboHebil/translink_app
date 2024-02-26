import 'package:cloud_firestore/cloud_firestore.dart';

import 'config.dart';

class FireAuthService {
  final _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference getUsersInfoCollection() {
    return _firebaseFirestore.collection('usersInfo');
  }

  Future<bool> isUserExist(String email) async {
    bool isExist = await Config.isExist(
        '${getUsersInfoCollection().path}/$email', _firebaseFirestore);
    return isExist;
  }

  Future<DocumentReference> getUserInfoDocument(String email) async {
    if (!await isUserExist(email)) {
      throw Exception(
          'There is no email with ($email) document called in (getUserInfoCollection())');
    }

    return getUsersInfoCollection().doc(email);
  }
}
