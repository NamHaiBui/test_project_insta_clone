import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';

import '../posts/typedefs/user_id.dart';

final userIdProvider = Provider<UserId?>(
  (ref) => ref.watch(authStateProvider).userId,
);
