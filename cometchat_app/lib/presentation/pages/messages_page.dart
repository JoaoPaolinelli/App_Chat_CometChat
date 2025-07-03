// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
// import 'package:cometchat_sdk/cometchat_sdk.dart';

// class MessagesPage extends StatelessWidget {
//   static const routeName = '/messages';

//   @override
//   Widget build(BuildContext context) {
//     final Conversation conv = Get.arguments as Conversation;

//     final isUser = conv.conversationType == ConversationType.user;
//     final isGroup = conv.conversationType == ConversationType.group;
//     final user = isUser ? conv.conversationWith as User : null;
//     final group = isGroup ? conv.conversationWith as Group : null;

//     return Scaffold(
//       appBar: AppBar(title: Text(isUser ? user!.name : group!.name)),
//       body: Column(
//         children: [
//           Expanded(child: CometChatMessageList(user: user, group: group)),
//           // <-- aqui está o composer certo:
//           CometChatMessageComposer(user: user, group: group),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_sdk/cometchat_sdk.dart';

class MessagesPage extends StatelessWidget {
  static const routeName = '/messages';

  @override
  Widget build(BuildContext context) {
    final Conversation conv = Get.arguments as Conversation;

    final bool isUser = conv.conversationType == ConversationType.user;
    final bool isGroup = conv.conversationType == ConversationType.group;
    final User? user = isUser ? conv.conversationWith as User : null;
    final Group? group = isGroup ? conv.conversationWith as Group : null;

    // Escolhe os dados corretos para avatar e título
    final String? avatarUrl = isUser ? user?.avatar : group?.icon;
    final String title = isUser ? user!.name : group!.name;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: BackButton(onPressed: () => Get.back()),
        title: Row(
          children: [
            // Avatar circular recortado
            ClipOval(
              child: Image.network(
                avatarUrl ?? '',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      width: 36,
                      height: 36,
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: CometChatMessageList(user: user, group: group)),
          CometChatMessageComposer(user: user, group: group),
        ],
      ),
    );
  }
}
