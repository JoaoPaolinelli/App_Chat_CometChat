import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initCometChat();
  }

  Future<void> _initCometChat() async {
    final uiKitSettings =
        (UIKitSettingsBuilder()
              ..appId = '278375cc346450df'
              ..region = 'us'
              ..authKey = 'fe876b8ca08f4f02527cd4484452457d51e75320'
              ..subscriptionType = CometChatSubscriptionType.allUsers
              ..autoEstablishSocketConnection = true
              ..extensions =
                  CometChatUIKitChatExtensions.getDefaultExtensions())
            .build();

    await CometChatUIKit.init(
      uiKitSettings: uiKitSettings,
      onSuccess: (_) => Navigator.pushReplacementNamed(context, '/login'),
      onError: (e) => debugPrint('Error: ${e.message}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
