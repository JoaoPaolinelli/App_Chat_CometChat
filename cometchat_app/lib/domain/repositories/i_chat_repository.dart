// lib/src/domain/repositories/i_chat_repository.dart

import 'package:cometchat_app/core/failures.dart';
import 'package:cometchat_app/domain/conversation_entity.dart';
import 'package:cometchat_app/domain/user_entity.dart';
import 'package:dartz/dartz.dart'; // <<-- importa Either, Left, Right

abstract class IChatRepository {
  /// Retorna um UserEntity ou uma Failure em caso de erro
  Future<Either<Failure, UserEntity>> login(String userId);

  /// Retorna a lista de conversas ou uma Failure em caso de erro
  Future<Either<Failure, List<ConversationEntity>>> getConversations();
}
