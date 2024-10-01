import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp_setup/features/auth/provider.dart';

class AuthController extends StateNotifier<AsyncValue<bool>> {
  AuthController(this.ref) : super(const AsyncValue.data(false));

  final Ref ref;

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final success = await ref.read(userRepositoryProvider).signIn(email, password);
      state = AsyncValue.data(success);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<bool>>((ref) {
  return AuthController(ref);
});