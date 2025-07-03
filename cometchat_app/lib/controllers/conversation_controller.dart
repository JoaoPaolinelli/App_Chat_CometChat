import 'package:cometchat_app/core/failures.dart';
import 'package:cometchat_app/domain/conversation_entity.dart';
import 'package:cometchat_app/domain/usecases/usecases.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/get_conversations_use_case.dart';

class ConversationsController extends GetxController {
  final GetConversationsUseCase getConversationsUseCase;

  final loading = false.obs;
  final error = RxnString();
  final conversations = <ConversationEntity>[].obs;

  ConversationsController({required this.getConversationsUseCase});

  @override
  void onInit() {
    super.onInit();
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    loading.value = true;
    error.value = null;

    final Either<Failure, List<ConversationEntity>> result =
        await getConversationsUseCase(NoParams());
    result.fold(
      (fail) {
        error.value = fail.message;
        loading.value = false;
      },
      (list) {
        conversations.assignAll(list);
        loading.value = false;
      },
    );
  }
}
