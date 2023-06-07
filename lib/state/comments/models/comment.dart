import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:test_project_insta_clone/state/comments/typedef/comment_id.dart';
import 'package:test_project_insta_clone/state/constants/firebase_field_name.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/post_id.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/user_id.dart';

@immutable
class Comment {
  Comment(Map<String, dynamic> json, {required this.id})
      : comment = json[FirebaseFieldName.comment],
        createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldName.userId],
        onPostId = json[FirebaseFieldName.postId];

  final String comment;
  final DateTime createdAt;
  final UserId fromUserId;
  final CommentId id;
  final PostId onPostId;

  @override
  bool operator ==(covariant other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId &&
          onPostId == other.onPostId;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          comment,
          createdAt,
          fromUserId,
          onPostId,
        ],
      );
}
