import 'package:collection/collection.dart';
import 'package:test_project_insta_clone/state/comments/models/comment.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';

class PostWithComments {
  final Post post;
  final Iterable<Comment> comments;
  PostWithComments({required this.post, required this.comments});

  @override
  bool operator ==(covariant other) =>
      identical(this, other) ||
      other is PostWithComments &&
          post == other.post &&
          const IterableEquality().equals(comments, other.comments);

  @override
  int get hashCode => Object.hashAll([post, comments]);
}
