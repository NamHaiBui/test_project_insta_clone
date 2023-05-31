import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/notifiers/auth_state_notifier.dart';

import '../auth/models/auth_state.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());
