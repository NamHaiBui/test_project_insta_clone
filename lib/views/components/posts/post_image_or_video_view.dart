import 'package:flutter/material.dart';
import 'package:test_project_insta_clone/state/image_upload/models/file_type.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';
import 'package:test_project_insta_clone/views/components/posts/post_image_view.dart';
import 'package:test_project_insta_clone/views/components/posts/post_video_view.dart';

class PostImageOrVideoWidget extends StatelessWidget {
  final Post post;
  const PostImageOrVideoWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(post: post);
      case FileType.video:
        return PostVideoView(post: post);
      default:
        return const SizedBox();
    }
  }
}
