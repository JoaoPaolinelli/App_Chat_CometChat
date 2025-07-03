import 'package:cometchat_app/core/failures.dart';
import 'package:cometchat_app/domain/usecases/usecases.dart';
import 'package:cometchat_app/domain/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../repositories/i_chat_repository.dart';

class LoginUseCase implements UseCase<UserEntity, String> {
  final IChatRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(String userId) {
    return repository.login(userId);
  }
}
