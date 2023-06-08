import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/likes/models/like_unlike_request.dart';
import 'package:test_project_insta_clone/state/likes/provider/has_liked_post_provider.dart';
import 'package:test_project_insta_clone/state/likes/provider/like_unlike_provider.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/post_id.dart';
import 'package:test_project_insta_clone/state/providers/user_id_provider.dart';
import 'package:test_project_insta_clone/views/components/animations/small_error_animation_view.dart';

class LikeButtonWidget extends ConsumerWidget {
  final PostId postId;
  const LikeButtonWidget({super.key, required this.postId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(
      postId,
    ));
    return hasLiked.when(
      data: (data) {
        return IconButton(
          icon: FaIcon(
              data ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart),
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            final likeRequest =
                LikeUnlikeRequest(postId: postId, likedBy: userId);
            ref.read(likeDislikePostProvider(likeRequest));
          },
        );
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
