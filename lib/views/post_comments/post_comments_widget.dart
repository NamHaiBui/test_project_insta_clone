import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/pages/constants/strings_for_content.dart';
import 'package:test_project_insta_clone/state/comments/models/post_comment_request.dart';
import 'package:test_project_insta_clone/state/comments/providers/post_comment_provider.dart';
import 'package:test_project_insta_clone/state/comments/providers/send_comment_provider.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/post_id.dart';
import 'package:test_project_insta_clone/state/providers/user_id_provider.dart';
import 'package:test_project_insta_clone/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:test_project_insta_clone/views/components/animations/error_animation_view.dart';
import 'package:test_project_insta_clone/views/components/animations/loading_animation_view.dart';
import 'package:test_project_insta_clone/views/components/comment/comment_tile.dart';
import 'package:test_project_insta_clone/views/components/constants/strings.dart';
import 'package:test_project_insta_clone/views/extensions/dismiss_keyboard.dart';

class PostCommentsWidget extends HookConsumerWidget {
  final PostId postId;
  const PostCommentsWidget({super.key, required this.postId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(RequestForPostAndComment(
      postId: postId,
    ));
    final comments = ref.watch(
      postCommentProvider(
        request.value,
      ),
    );
    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return null;
    }, [commentController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.comment,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.send),
              onPressed: hasText.value
                  ? () {
                      _submitCommentWithController(
                        commentController,
                        ref,
                      );
                    }
                  : null)
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 3,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentWithTextAnimationView(
                        text: StringsForContent.noCommentsYet,
                      ),
                    );
                  }
                  return RefreshIndicator(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments.elementAt(index);
                          return CommentTile(comment: comment);
                        },
                      ),
                      onRefresh: () {
                        // ignore: unused_result
                        ref.refresh(postCommentProvider(request.value));
                        return Future.delayed(const Duration(seconds: 1));
                      });
                },
                error: (error, stackTrace) {
                  return const ErrorAnimationView();
                },
                loading: () {
                  return const LoadingAnimationView();
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextField(
                    controller: commentController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (comment) {
                      _submitCommentWithController(commentController, ref);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: StringsForContent.writeYourCommentHere,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
      TextEditingController controller, WidgetRef ref) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text,
        );
    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
