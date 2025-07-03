import 'package:cometchat_app/core/failures.dart';
import 'package:cometchat_app/domain/user_entity.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/login_use_case.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  // Estado reativo
  final loading = false.obs;
  final error = RxnString();

  LoginController({required this.loginUseCase});

  Future<void> login(String userId) async {
    loading.value = true;
    error.value = null;

    final Either<Failure, UserEntity> result = await loginUseCase(userId);
    result.fold(
      (fail) {
        error.value = fail.message;
        loading.value = false;
      },
      (user) {
        loading.value = false;
        Get.offNamed('/conversations');
      },
    );
  }
}
