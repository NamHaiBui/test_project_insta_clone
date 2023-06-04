import 'package:flutter/material.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';
import 'package:test_project_insta_clone/state/posts/post_thumbnail_widget.dart';

class PostsGridWidget extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsGridWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);

        return PostThumbnailWidget(post: post, onTap: () {});
      },
    );
  }
}
