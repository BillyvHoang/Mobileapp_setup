


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp_setup/features/auth/data/repo/user_repo.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());