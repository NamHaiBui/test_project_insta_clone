import 'package:flutter/foundation.dart' show immutable;

import '../../constants/firebase_collection_name.dart';
import '../../constants/firebase_field_name.dart';
import '../../posts/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_info_payload.dart';

final firestore = FirebaseFirestore.instance;

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    //first check if we have this user's info from before
    final userInfo = await firestore
        .collection(
          FirebaseCollectionName.users,
        )
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .limit(1) //get the first match
        .get();

    //we already have this user's info then we update the person credentials
    if (userInfo.docs.isNotEmpty) {
      await userInfo.docs.first.reference.update(
        {
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        },
      );
      return true;
    }
    // we don';'t have this user's info from before so we create a new user profile
    final payload = UserInfoPayload(
      userId: userId,
      displayName: displayName,
      email: email,
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .add(payload);
      return true;
    } catch (e) {
      return false;
    }
  }
}
