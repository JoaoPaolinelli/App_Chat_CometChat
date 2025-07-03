// lib/src/data/datasources/comet_chat_remote_data_source.dart

import 'dart:async';

import 'package:cometchat_app/data/conversation_model.dart';
import 'package:cometchat_app/data/user_model.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart'; // para CometChatUIKit.login
import 'package:cometchat_sdk/cometchat_sdk.dart'; // para o builder de conversas

abstract class RemoteDataSource {
  Future<UserModel> login(String userId);
  Future<List<ConversationModel>> fetchConversations();
}

class CometChatRemoteDataSource implements RemoteDataSource {
  @override
  Future<UserModel> login(String userId) {
    final completer = Completer<User>();
    CometChatUIKit.login(
      userId,
      onSuccess: completer.complete,
      onError: completer.completeError,
    );
    return completer.future.then(UserModel.fromSdk);
  }

  @override
  Future<List<ConversationModel>> fetchConversations() async {
    // Cria o request
    final request = (ConversationsRequestBuilder()..limit = 30).build();

    // Usa um Completer para transformar callbacks em Future
    final completer = Completer<List<Conversation>>();

    request.fetchNext(
      onSuccess: (List<Conversation> list) {
        completer.complete(list);
      },
      onError: (CometChatException e) {
        completer.completeError(e);
      },
    );

    // Aguarda o resultado
    final sdkList = await completer.future;

    // Mapeia para nossos models
    return sdkList.map(ConversationModel.fromSdk).toList(growable: false);
  }
}
