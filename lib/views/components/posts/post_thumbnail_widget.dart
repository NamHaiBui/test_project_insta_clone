import 'package:flutter/material.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';

class PostThumbnailWidget extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostThumbnailWidget(
      {super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Image.network(
          post.thumbnailUrl,
          fit: BoxFit.cover,
        ));
  }
}
