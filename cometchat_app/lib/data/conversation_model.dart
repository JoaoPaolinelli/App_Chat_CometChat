// lib/src/data/models/conversation_model.dart

import 'package:cometchat_app/domain/conversation_entity.dart';

import 'package:cometchat_sdk/cometchat_sdk.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required String? id,
    required String title,
    required String lastMessage,
    required String type,
  }) : super(id: id, title: title, lastMessage: lastMessage, type: type);

  /// Constrói a partir do SDK
  factory ConversationModel.fromSdk(Conversation sdkConv) {
    // ID
    final String? id = sdkConv.conversationId;

    // Tipo
    final String type = sdkConv.conversationType;

    // Última mensagem: se for TextMessage, pega .text, se não, string vazia
    String lastMsg = '';
    if (sdkConv.lastMessage is TextMessage) {
      lastMsg = (sdkConv.lastMessage as TextMessage).text;
    }

    // Título: usuário ou grupo
    String title = '';
    final entity = sdkConv.conversationWith;
    if (entity is User) {
      title = entity.name;
    } else if (entity is Group) {
      title = entity.name; // Group.name retorna o nome do grupo
    }

    return ConversationModel(
      id: id,
      title: title,
      lastMessage: lastMsg,
      type: type,
    );
  }
}
