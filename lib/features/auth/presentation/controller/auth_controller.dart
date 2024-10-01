import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp_setup/features/auth/data/repo/user_repo.dart';

class AuthController extends StateNotifier<AsyncValue<bool>> {
  AuthController(this.ref) : super(const AsyncValue.data(false));

  final Ref ref;

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final success = await ref.read(userRepositoryProvider).signIn(email, password);
      state = AsyncValue.data(success);
      print('Sign in success: $success');
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final success = await ref.read(userRepositoryProvider).signUp(name, email, password);
      state = AsyncValue.data(success);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<bool>>((ref) {
  return AuthController(ref);
});

final userRepositoryProvider = Provider((ref) => UserRepository());