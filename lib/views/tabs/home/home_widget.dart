import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/pages/constants/strings_for_content.dart';
import 'package:test_project_insta_clone/state/posts/providers/all_post_provider.dart';
import 'package:test_project_insta_clone/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:test_project_insta_clone/views/components/animations/error_animation_view.dart';
import 'package:test_project_insta_clone/views/components/posts/post_grid_widget.dart';

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostProvider);

    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(allPostProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (data) {
          if (data.isEmpty) {
            return const EmptyContentWithTextAnimationView(
                text: StringsForContent.noPostsAvailable);
          }
          return PostsGridWidget(posts: data);
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
