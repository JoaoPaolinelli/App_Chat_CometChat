import 'package:cometchat_app/presentation/pages/conversation_page.dart';
import 'package:cometchat_app/presentation/pages/login_page.dart';
import 'package:cometchat_app/presentation/pages/messages_page.dart';
import 'package:cometchat_app/presentation/pages/users_page.dart';
import 'package:cometchat_app/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Esconde Translations do GetX
import 'package:get/get.dart' hide Translations;
import 'package:flutter_localizations/flutter_localizations.dart';
// Traz Translations do CometChat UI Kit
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

import 'package:cometchat_app/controllers/login_controller.dart';
import 'package:cometchat_app/controllers/conversation_controller.dart';
import 'package:cometchat_app/data/comet_chat_remote_data_source.dart';
import 'package:cometchat_app/data/repositories/chat_repository_impl.dart';
import 'package:cometchat_app/domain/usecases/login_use_case.dart';
import 'package:cometchat_app/domain/usecases/get_conversations_use_case.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light, // para iOS
    ),
  );

  // 1️⃣ Inicializa o SDK core

  // 2️⃣ Depois inicializa o UI Kit
  await CometChatUIKit.init(
    uiKitSettings:
        (UIKitSettingsBuilder()
              ..appId = '278375cc346450df'
              ..region = 'us'
              ..authKey = 'fe876b8ca08f4f02527cd4484452457d51e75320'
              ..subscriptionType = CometChatSubscriptionType.allUsers
              ..autoEstablishSocketConnection = true)
            .build(),
  );

  // 3️⃣ Configurações de DI/GetX (controllers, datasources, usecases)…
  final remoteDs = CometChatRemoteDataSource();
  final repo = ChatRepositoryImpl(remoteDs);
  final loginUC = LoginUseCase(repo);
  final convUC = GetConversationsUseCase(repo);

  Get.put(LoginController(loginUseCase: loginUC));
  Get.put(ConversationsController(getConversationsUseCase: convUC));

  // 4️⃣ Roda o app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 1️⃣ Defina o theme com appBarTheme que inclui systemOverlayStyle
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          // Esse style faz a status bar ficar branca com ícones escuros
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      // 2️⃣ Também garanta que, ao iniciar, a status bar já esteja configurada
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        );
        return child!;
      },

      title: 'CometChat Base',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt'),
      supportedLocales: const [Locale('pt'), Locale('en')],
      localizationsDelegates: const [
        Translations.delegate, // do UI Kit
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: SplashPage.routeName,
      getPages: [
        GetPage(name: SplashPage.routeName, page: () => SplashPage()),
        GetPage(name: LoginPage.routeName, page: () => LoginPage()),
        GetPage(
          name: ConversationsPage.routeName,
          page: () => ConversationsPage(),
        ),
        GetPage(name: MessagesPage.routeName, page: () => MessagesPage()),
        GetPage(name: UsersPage.routeName, page: () => const UsersPage()),
      ],
    );
  }
}
