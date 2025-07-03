import 'package:cometchat_app/core/failures.dart';
import 'package:dartz/dartz.dart';

/// T é o tipo de retorno, P os parâmetros (pode ser void ou NoParams).
abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

/// Para casos que não recebem parâmetro
class NoParams {}
