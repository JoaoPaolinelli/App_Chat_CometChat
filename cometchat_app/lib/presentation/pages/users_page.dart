// // lib/src/presentation/pages/users/users_page.dart

// import 'package:cometchat_app/pages/chat_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

// class UsersPage extends StatelessWidget {
//   static const routeName = '/users';
//   const UsersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Selecione um usuário')),
//       body: SafeArea(
//         child: CometChatUsers(
//           onItemTap: (ctx, user) {
//             Get.to(() => ChatPage(user: user));
//           },
//         ),
//       ),
//     );
//   }
// }
// lib/src/presentation/pages/users/users_page.dart

import 'package:cometchat_app/pages/messages_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_sdk/cometchat_sdk.dart';

class UsersPage extends StatelessWidget {
  static const routeName = '/users';
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Selecione um usuário')),
      body: SafeArea(
        child: CometChatUsers(
          onItemTap: (ctx, user) {
            // 1) Cria a Conversation para chat 1-a-1
            final conv = Conversation(
              conversationId: user.uid,
              conversationType: ConversationType.user,
              conversationWith: user,
            );
            // 2) Substitui a rota atual pela MessagesPage
            Get.offNamed(MessagesPage.routeName, arguments: conv);
          },
        ),
      ),
    );
  }
}
