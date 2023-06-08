import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/posts/notifiers/delete_post_notifier.dart';

final deletePostProvider = StateNotifierProvider<DeletePostNotifier, bool>(
    (ref) => DeletePostNotifier());
