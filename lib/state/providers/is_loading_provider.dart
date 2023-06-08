import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/comments/providers/delete_comment_provider.dart';
import 'package:test_project_insta_clone/state/comments/providers/send_comment_provider.dart';
import 'package:test_project_insta_clone/state/image_upload/provider/image_uploader_provider.dart';
import 'package:test_project_insta_clone/state/posts/providers/delete_post_provider.dart';
import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';

final isLoadingProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  return authState.isLoading ||
      isUploadingImage ||
      isSendingComment ||
      isDeletingComment ||
      isDeletingPost;
});
