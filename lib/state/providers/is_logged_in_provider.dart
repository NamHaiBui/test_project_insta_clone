import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';

import '../auth/models/auth_result.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});
