import 'package:flutter/material.dart';
import 'package:test_project_insta_clone/pages/post_details_page.dart';
import 'package:test_project_insta_clone/views/components/posts/post_thumbnail_widget.dart';

import '../../../state/posts/models/post.dart';

class PostsSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsSliverGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      delegate: SliverChildBuilderDelegate(childCount: posts.length,
          (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailWidget(
            post: post,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PostDetailsPage(post: post);
                },
              ));
            });
      }),
    );
  }
}
