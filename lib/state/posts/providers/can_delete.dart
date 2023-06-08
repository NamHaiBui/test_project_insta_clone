import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';
import 'package:test_project_insta_clone/state/providers/user_id_provider.dart';

// constantly yielding whether or not the current userId is the user that created the post to check
//whether the current user can delete the post
final canDeleteProvider =
    StreamProvider.family.autoDispose<bool, Post>((ref, post) async* {
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
});
