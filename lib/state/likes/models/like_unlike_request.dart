import 'package:flutter/material.dart' show immutable;
import 'package:test_project_insta_clone/state/posts/typedefs/post_id.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/user_id.dart';

@immutable
class LikeUnlikeRequest {
  final PostId postId;
  final UserId likedBy;
  const LikeUnlikeRequest({required this.postId, required this.likedBy});
}
