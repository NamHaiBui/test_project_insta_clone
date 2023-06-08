import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:test_project_insta_clone/state/comments/models/comment.dart';
import 'package:test_project_insta_clone/state/user_info/providers/user_info_model_provider.dart';
import 'package:test_project_insta_clone/views/components/animations/small_error_animation_view.dart';
import 'package:test_project_insta_clone/views/components/rich_two_part_text.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({super.key, required this.comment});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoModelProvider(comment.fromUserId));
    return userInfo.when(
      data: (data) {
        return RichTwoPartText(
            leftPart: data.displayName, rightPart: comment.comment);
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
