import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasselni_driver/features/authentication/data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final loginControllerProvider = AsyncNotifierProvider<LoginController, void>(
  LoginController.new,
);

class LoginController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> login({required String phone, required String password}) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(authRepositoryProvider)
          .login(phone: phone, password: password);

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
