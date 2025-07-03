// lib/src/presentation/pages/conversations/conversations_page.dart

import 'package:cometchat_app/controllers/conversation_controller.dart';
import 'package:cometchat_app/pages/messages_page.dart';
import 'package:cometchat_app/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

class ConversationsPage extends StatelessWidget {
  static const routeName = '/conversations';
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ConversationsController>();
    return Scaffold(
      // appBar: AppBar(title: const Text('Conversas')),
      body: Obx(() {
        if (ctrl.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (ctrl.error.value != null) {
          return Center(
            child: Text(
              ctrl.error.value!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return SafeArea(
          child: CometChatConversations(
            onItemTap:
                (conv) => Get.toNamed(MessagesPage.routeName, arguments: conv),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed(UsersPage.routeName);
        },
      ),
    );
  }
}
