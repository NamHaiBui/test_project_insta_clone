import 'package:flutter/foundation.dart';
import 'package:test_project_insta_clone/enums/date_sorting.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/post_id.dart';

@immutable
class RequestForPostAndComment {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting order;
  final int? limit;

  const RequestForPostAndComment(
      {required this.postId,
      this.sortByCreatedAt = true,
      this.order = DateSorting.newestOnTop,
      this.limit});
  @override
  bool operator ==(covariant RequestForPostAndComment other) =>
      postId == other.postId &&
      sortByCreatedAt == other.sortByCreatedAt &&
      order == other.order &&
      limit == other.limit;

  @override
  int get hashCode => Object.hashAll([
        postId,
        sortByCreatedAt,
        order,
        limit,
      ]);
}
