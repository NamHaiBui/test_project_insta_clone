import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:test_project_insta_clone/enums/date_sorting.dart';
import 'package:test_project_insta_clone/pages/constants/strings_for_content.dart';
import 'package:test_project_insta_clone/state/comments/models/post_comment_request.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';
import 'package:test_project_insta_clone/state/posts/providers/can_delete.dart';
import 'package:test_project_insta_clone/state/posts/providers/delete_post_provider.dart';
import 'package:test_project_insta_clone/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:test_project_insta_clone/views/components/animations/error_animation_view.dart';
import 'package:test_project_insta_clone/views/components/animations/small_error_animation_view.dart';
import 'package:test_project_insta_clone/views/components/comment/compact_comment_column.dart';
import 'package:test_project_insta_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:test_project_insta_clone/views/components/dialogs/delete_dialog.dart';
import 'package:test_project_insta_clone/views/components/like_button_widget.dart';
import 'package:test_project_insta_clone/views/components/likes_count_view.dart';
import 'package:test_project_insta_clone/views/components/posts/post_date_view.dart';
import 'package:test_project_insta_clone/views/components/posts/post_display_name_and_message_view.dart';
import 'package:test_project_insta_clone/views/components/posts/post_image_or_video_view.dart';
import 'package:test_project_insta_clone/views/post_comments/post_comments_widget.dart';

class PostDetailsPage extends ConsumerStatefulWidget {
  const PostDetailsPage({super.key, required this.post});

  final Post post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsPageState();
}

class _PostDetailsPageState extends ConsumerState<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComment(
        postId: widget.post.postId,
        limit: 3,
        sortByCreatedAt: true,
        order: DateSorting.oldestOnTop);
    //send the request to get the actual post with comment
    final postWithComments =
        ref.watch(specificPostWithCommentsProvider(request));
    // can the current user delete the post
    final canDelete = ref.watch(canDeleteProvider(widget.post));
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsForContent.postDetails),
        actions: [
          postWithComments.when(
            data: (data) {
              return IconButton(
                  onPressed: () {
                    final url = data.post.fileUrl;
                    Share.share(
                      url,
                      subject: StringsForContent.checkOutThisPost,
                    );
                  },
                  icon: const Icon(Icons.share));
            },
            error: (error, stackTrace) {
              return const SmallErrorAnimationView();
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          ),
          if (canDelete.value ?? false)
            IconButton(
                onPressed: () async {
                  final shouldDeletePost = await DeleteDialog(
                          titleOfObjectTobeDeleted: StringsForContent.post)
                      .present(context)
                      .then((shouldDelete) => shouldDelete ?? false);
                  if (shouldDeletePost) {
                    await ref
                        .read(deletePostProvider.notifier)
                        .deletePost(post: widget.post);
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                icon: const Icon(Icons.delete)),
        ],
      ),
      body: postWithComments.when(
        data: (data) {
          final postId = data.post.postId;
          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PostImageOrVideoWidget(post: data.post),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (data.post.allowLikes) LikeButtonWidget(postId: postId),
                  if (data.post.allowComments)
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return PostCommentsWidget(postId: postId);
                            },
                          ));
                        },
                        icon: const Icon(Icons.mode_comment_outlined)),
                  PostDisplayNameAndMessageView(post: data.post),
                  PostDateView(datetime: data.post.createdAt),
                  const Divider(color: Colors.white70),
                  CompactCommentColumn(comments: data.comments),
                  if (data.post.allowLikes)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          LikesCountView(postId: postId),
                        ],
                      ),
                    )
                ],
              ),
              const SizedBox(height: 100),
            ],
          ));
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
