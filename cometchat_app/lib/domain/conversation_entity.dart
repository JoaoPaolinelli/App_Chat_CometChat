/// Entidade simples de Conversa, mapeada a partir do SDK
class ConversationEntity {
  final String? id;
  final String title;
  final String lastMessage;
  final String type; // SDK usa String para conversationType

  ConversationEntity({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.type,
  });

  /// Factory para converter direto do objeto Conversation do SDK
  factory ConversationEntity.fromSdk(dynamic sdkConversation) {
    // sdkConversation.conversationId é String?
    final String? id = sdkConversation.conversationId as String?;

    // O SDK expõe lastMessage possivelmente nulo
    final String lastMsg = (sdkConversation.lastMessage?.text as String?) ?? '';

    // conversationType vem como String
    final String type = sdkConversation.conversationType as String;

    // conversationWith pode ser User ou Group, extraímos o name se existir
    String title = '';
    final withEntity = sdkConversation.conversationWith;
    if (withEntity != null) {
      // User e Group no SDK têm campo 'name'
      final dynamic maybeName = withEntity.name;
      title = (maybeName is String) ? maybeName : '';
    }

    return ConversationEntity(
      id: id,
      title: title,
      lastMessage: lastMsg,
      type: type,
    );
  }
}
