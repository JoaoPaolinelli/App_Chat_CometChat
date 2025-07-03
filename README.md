## *Select a language*
<p align="center"> 
  <a href="#português"><img src="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/br.svg" alt="Português" width="48" /></a>
  &nbsp;&nbsp;
  <a href="#english"><img src="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/us.svg" alt="English" width="48" /></a>
</p>

---

## 🇧🇷 <a name="português"></a>

# CometChat Flutter – Integração UI Kit

Uma aplicação de exemplo em **Flutter** que integra o **CometChat UI Kit** utilizando **Clean Architecture** e **GetX** para gerenciamento de estado e navegação.

---

## 🛠️ Tecnologias

- Flutter  
- CometChat SDK & CometChat UI Kit  
- GetX (injeção, estado e navegação)  
- Dartz (Either para tratamento de erros)  
- Clean Architecture

---

## 📦 Instalação

1. Clone este repositório:  
   ```bash
   git clone https://github.com/joaoPaolinelli/App_Chat_CometChat
   cd cometchat_flutter
2. Defina seu App ID e Auth Key no main.dart.
    ```bash
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

3. No Android, garanta permissão de Internet em android/app/src/main/AndroidManifest.xml:
   ```bash
    <uses-permission android:name="android.permission.INTERNET"/>
4. Instale dependências:
   ```bash
   flutter pub get

5. Execute no emulador ou dispositivo:
   ```bash
    flutter run

## 🚀 Funcionalidades Principais
1. Login de usuário via CometChat UI Kit

2. Listagem de conversas (1-a-1 e grupos)

3. Chat com histórico de mensagens e envio de texto/imagem

4. Seleção de usuários para iniciar nova conversa

5. Navegação suave com GetX

## 🧩 Arquitetura
    ```bash
    lib/
    ├── core/              # Erros e contrato de UseCase
    ├── domain/            # Entities, Repositories Interfaces, UseCases
    ├── data/              # Models, Datasources, RepositoryImpl
    └── presentation/
        ├── controllers/   # GetX Controllers (Login, Conversations)
        ├── pages/         # UI: Splash, Login, Conversations, Messages, Users
        └── widgets/       # Componentes compartilhados (Loading, Error)


## 🔍 Code Snippets

1. Login de usuário
    ```bash
    // login_controller.dart
    class LoginController extends GetxController {
      final LoginUseCase loginUseCase;
      final loading = false.obs;
      final error   = RxnString();
    
      Future<void> login(String uid) async {
        loading.value = true;
        final result = await loginUseCase(uid);
        result.fold(
          (f) => error.value = f.message,
          (_) => Get.offNamed('/conversations'),
        );
        loading.value = false;
      }
    }
2. Fetch de conversas
   ```bash
    // data/comet_chat_remote_data_source.dart
    final completer = Completer<List<Conversation>>();
    ConversationsRequestBuilder().build().fetchNext(
      onSuccess: completer.complete,
      onError:   completer.completeError,
    );
    final list = await completer.future;

4. Data Layer → Model
   ```bash
    // conversation_model.dart
    factory ConversationModel.fromSdk(Conversation sdk) {
      final lastMsg = sdk.lastMessage is TextMessage
          ? (sdk.lastMessage as TextMessage).text
          : '';
      final title = sdk.conversationWith is User
          ? (sdk.conversationWith as User).name
          : (sdk.conversationWith as Group).name;
      return ConversationModel(
        id: sdk.conversationId,
        title: title,
        lastMessage: lastMsg,
        type: sdk.conversationType,
      );
    }

6. MessagesPage (UI)
   ```bash
    // messages_page.dart
    AppBar(
      title: Row(
        children: [
          ClipOval(
            child: Image.network(
              avatarUrl,
              width: 36,
              height: 36,
              errorBuilder: (_,__,___) => Icon(Icons.person),
            ),
          ),
          SizedBox(width: 12),
          Text(title),
        ],
      ),
    ),
    body: Column(
      children: [
        Expanded(child: CometChatMessageList(user: user, group: group)),
        CometChatMessageComposer(user: user, group: group),
      ],
    
    ),


## ⚠️ Issues faced during implementation
1. Erro de NDK no Android

    ```bash
    Sintoma: Falha no build por falta de source.properties.
    
    Solução: Remover ndkVersion dos scripts e definir ndk.dir em android/local.properties.

3. Conflito de import de Translations
    ```bash
    Sintoma: Ambiguidade entre GetX e CometChat UI Kit.
    
    Solução:
    import 'package:get/get.dart' hide Translations;
    import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';


3. Incompatibilidades de tipo
   ```bash
    Sintoma: conversationId era String?, conversationType era String, lastMessage nulo.
    
    Solução: Armazenar o próprio Conversation do SDK e mapear via factory ConversationEntity.fromSdk.

4. APIs baseadas em callbacks
    ```bash
    Sintoma: Métodos login e fetchNext usam onSuccess/onError.
    
    Solução: Envolver em Completer<T> para converter em Future<T>.

## 💡 How you resolved them

1. Clean Architecture: separação clara entre domínio, dados e apresentação.

2. GetX: navegação e estado reativos padronizados.


3. Dartz: uso de Either para tratar erros de forma funcional.

4. Flutter native: uso de Image.network com errorBuilder para avatars, permissão de Internet no Android.

## 📸 Screenshots of successful integration
Para comprovar a integração, trouxe capturas de tela do aplicativo:

### 1. LoginPage
![login](https://github.com/user-attachments/assets/9cc0e8fe-a804-49fa-a679-c54040405381)


### 2. Lista de Conversas
![01](https://github.com/user-attachments/assets/8c8a6c84-3aec-4478-a933-d0f8fdcc33c6)

### 4. Chat 1-a-1
![04](https://github.com/user-attachments/assets/8f086a33-6d94-4236-8583-24880cd7fca2)

### 5. Chat em Grupo
![05](https://github.com/user-attachments/assets/38a3d7f0-f544-478f-9ba5-e379facdf199)

## 🎯 Próximos passos
1. Implementar Dark Mode / Tema customizado

2. Adicionar Push Notifications

3. Cobrir com Tests (unitários e de widget)

4. Polir animações e UX

## 📬 Contato

Se você quiser entrar em contato comigo, fique à vontade:

- **Telefone:** [(31) 99155-7502](tel:+5531991557502)  
- **E-mail:** [joaopaolinelli@gmail.cocm](mailto:joaopaolinelli@gmail.com)



## USA <a name="english"></a>

# CometChat Flutter – UI Kit Integration

A sample **Flutter** application integrating the **CometChat UI Kit** using **Clean Architecture** and **GetX** for state management and navigation.

---

## 🛠️ Technologies

- Flutter  
- CometChat SDK & CometChat UI Kit  
- GetX (dependency injection, state & navigation)  
- Dartz (Either for error handling)  
- Clean Architecture
  
---

## 📦 Instalação

1. Clone this repository:  
   ```bash
   git clone https://github.com/joaoPaolinelli/App_Chat_CometChat
   cd cometchat_flutter
2. Set your App ID and Auth Key in main.dart.
    ```bash
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

3. On Android, ensure Internet permission in:
   ```bash
    <uses-permission android:name="android.permission.INTERNET"/>
4. Install dependencies::
   ```bash
   flutter pub get

5. Run on emulator or device:
   ```bash
    flutter run

## 🚀 Main Features
1. User login via CometChat UI Kit

2. Conversation list (1-on-1 and group)

3. Chat with message history and text/image sending

4. User picker to start new 1-on-1 chat

5. Smooth navigation with GetX

## 🧩 Architecture
    ```bash
    lib/
    ├── core/              # Failures and UseCase contract
    ├── domain/            # Entities, Repository Interfaces, UseCases
    ├── data/              # Models, DataSources, RepositoryImpl
    └── presentation/
        ├── controllers/   # GetX Controllers (Login, Conversations)
        ├── pages/         # UI: Splash, Login, Conversations, Messages, Users
        └── widgets/       # Shared components (Loading, Error)


## 🔍 Code Snippets

1. User Login
    ```bash
    // login_controller.dart
    class LoginController extends GetxController {
      final LoginUseCase loginUseCase;
      final loading = false.obs;
      final error   = RxnString();
    
      Future<void> login(String uid) async {
        loading.value = true;
        final result = await loginUseCase(uid);
        result.fold(
          (f) => error.value = f.message,
          (_) => Get.offNamed('/conversations'),
        );
        loading.value = false;
      }
    }
2. Fetch Conversations
   ```bash
    // data/comet_chat_remote_data_source.dart
    final completer = Completer<List<Conversation>>();
    ConversationsRequestBuilder().build().fetchNext(
      onSuccess: completer.complete,
      onError:   completer.completeError,
    );
    final list = await completer.future;

3. Data Layer → Model Mapping
   ```bash
    // conversation_model.dart
    factory ConversationModel.fromSdk(Conversation sdk) {
      final lastMsg = sdk.lastMessage is TextMessage
          ? (sdk.lastMessage as TextMessage).text
          : '';
      final title = sdk.conversationWith is User
          ? (sdk.conversationWith as User).name
          : (sdk.conversationWith as Group).name;
      return ConversationModel(
        id: sdk.conversationId,
        title: title,
        lastMessage: lastMsg,
        type: sdk.conversationType,
      );
    }

5. Data Layer → Model
   ```bash
    // conversation_model.dart
    factory ConversationModel.fromSdk(Conversation sdk) {
      final lastMsg = sdk.lastMessage is TextMessage
          ? (sdk.lastMessage as TextMessage).text
          : '';
      final title = sdk.conversationWith is User
          ? (sdk.conversationWith as User).name
          : (sdk.conversationWith as Group).name;
      return ConversationModel(
        id: sdk.conversationId,
        title: title,
        lastMessage: lastMsg,
        type: sdk.conversationType,
      );
    }

5. MessagesPage (UI)
   ```bash
    // messages_page.dart
    AppBar(
      title: Row(
        children: [
          ClipOval(
            child: Image.network(
              avatarUrl,
              width: 36,
              height: 36,
              errorBuilder: (_,__,___) => Icon(Icons.person),
            ),
          ),
          SizedBox(width: 12),
          Text(title),
        ],
      ),
    ),
    body: Column(
      children: [
        Expanded(child: CometChatMessageList(user: user, group: group)),
        CometChatMessageComposer(user: user, group: group),
      ],
    
    ),


## ⚠️ Issues faced during implementation
1. Erro de NDK no Android

    ```bash
     Symptom: Build failed due to missing source.properties.
    Resolution: Removed ndkVersion from Gradle scripts and set ndk.dir in android/local.properties.

2. Translations Import Conflict
    ```bash
    Symptom: Ambiguous import between GetX and CometChat UI Kit.
    
    Resolution:
    import 'package:get/get.dart' hide Translations;
    import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';


3. Type Incompatibilities
   ```bash
   Symptom: conversationId was String?, conversationType a String, lastMessage nullable.

    Resolution:
    
    Kept id as String?.
    
    Treated type as String.
    
    Accessed sdkConversation.lastMessage?.text with ?. and default ''.
    
    Checked if conversationWith is User or Group before calling .name.

4. Callback-based APIs
    ```bash
    Symptom: login and fetchNext use onSuccess/onError.
    Resolution: Wrapped in Completer<T> to expose as Future<T>.
    
## 💡 How you resolved them

1. Clean Architecture: separação clara entre domínio, dados e apresentação.

2. GetX: navegação e estado reativos padronizados.


3. Dartz: uso de Either para tratar erros de forma funcional.

4. Flutter native: uso de Image.network com errorBuilder para avatars, permissão de Internet no Android.

## 📸 Screenshots of successful integration


### 1. LoginPage
![login](https://github.com/user-attachments/assets/9cc0e8fe-a804-49fa-a679-c54040405381)


### 2. Conversation List
![01](https://github.com/user-attachments/assets/8c8a6c84-3aec-4478-a933-d0f8fdcc33c6)

### 4. One-on-One Chat
![04](https://github.com/user-attachments/assets/8f086a33-6d94-4236-8583-24880cd7fca2)

### 5. Group Chat
![05](https://github.com/user-attachments/assets/38a3d7f0-f544-478f-9ba5-e379facdf199)

## 🎯 Próximos passos
1. Implement Dark Mode / Custom Theme

2. Add Push Notifications

3. Cover with Tests (unit & widget)

4. Polish animations & UX

## 📬 Contact

- **Phone:** [(31) 99155-7502](tel:+5531991557502)  
- **Email:** [joaopaolinelli@gmail.cocm](mailto:joaopaolinelli@gmail.com)
