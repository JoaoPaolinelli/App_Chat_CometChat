import 'package:cometchat_app/core/failures.dart';
import 'package:cometchat_app/data/comet_chat_remote_data_source.dart';
import 'package:cometchat_app/domain/conversation_entity.dart';
import 'package:cometchat_app/domain/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/i_chat_repository.dart';

class ChatRepositoryImpl implements IChatRepository {
  final RemoteDataSource remote;

  ChatRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, UserEntity>> login(String userId) async {
    try {
      final user = await remote.login(userId);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final list = await remote.fetchConversations();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
