import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/comments/notifiers/send_comment_notifier.dart';
import 'package:test_project_insta_clone/state/image_upload/typedefs/is_loading.dart';

final sendcommentProvider =
    StateNotifierProvider<SendCommentNotifier, IsLoading>(
  (ref) {
    return SendCommentNotifier();
  },
);
