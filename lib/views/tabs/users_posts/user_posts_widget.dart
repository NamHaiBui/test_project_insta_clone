import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/pages/constants/strings_for_content.dart';
import 'package:test_project_insta_clone/views/components/posts/post_grid_widget.dart';
import 'package:test_project_insta_clone/state/posts/providers/user_posts_provider.dart';
import 'package:test_project_insta_clone/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:test_project_insta_clone/views/components/animations/error_animation_view.dart';
import 'package:test_project_insta_clone/views/components/animations/loading_animation_view.dart';

class UserPostWidget extends ConsumerWidget {
  const UserPostWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //async value is like a proxy object that
    //allows you to build various widgets dependent on the state of your provider
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(userPostsProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentWithTextAnimationView(
              text: StringsForContent.youHaveNoPosts,
            );
          } else {
            return PostsGridWidget(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
