import 'package:cometchat_app/domain/user_entity.dart';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

class UserModel extends UserEntity {
  UserModel({required String uid, required String name, required String avatar})
    : super(uid: uid, name: name, avatar: avatar);

  /// Constrói o UserModel a partir do SDK
  factory UserModel.fromSdk(User sdkUser) {
    return UserModel(
      uid: sdkUser.uid,
      name: sdkUser.name,
      avatar: sdkUser.avatar ?? '',
    );
  }
}
