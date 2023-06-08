import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/pages/constants/strings_for_content.dart';
import 'package:test_project_insta_clone/state/posts/providers/posts_by_search_term_provider.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/search_term.dart';
import 'package:test_project_insta_clone/views/components/animations/data_not_found_animaion_view.dart';
import 'package:test_project_insta_clone/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:test_project_insta_clone/views/components/animations/error_animation_view.dart';
import 'package:test_project_insta_clone/views/components/posts/post_sliver_grid_view.dart';

class SearchGridView extends ConsumerWidget {
  const SearchGridView({super.key, required this.searchTerm});
  final SearchTerm searchTerm;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentWithTextAnimationView(
            text: StringsForContent.enterYourSearchTerm),
      );
    }
    final posts = ref.watch(postsBySearchTermProvider(searchTerm));
    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(child: DataNotFoundAnimationView());
        } else {
          return PostsSliverGridView(posts: posts);
        }
      },
      error: (_, __) {
        return const SliverToBoxAdapter(child: ErrorAnimationView());
      },
      loading: () {
        return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
