import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/comments/notifiers/delete_comment_notifiers.dart';
import 'package:test_project_insta_clone/state/image_upload/typedefs/is_loading.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifier, IsLoading>(
        (ref) => DeleteCommentNotifier());
