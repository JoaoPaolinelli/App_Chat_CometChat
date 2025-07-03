import 'package:cometchat_app/core/failures.dart';
import 'package:cometchat_app/domain/conversation_entity.dart';
import 'package:cometchat_app/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import '../repositories/i_chat_repository.dart';

class GetConversationsUseCase
    implements UseCase<List<ConversationEntity>, NoParams> {
  final IChatRepository repository;
  GetConversationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ConversationEntity>>> call(NoParams params) {
    return repository.getConversations();
  }
}
