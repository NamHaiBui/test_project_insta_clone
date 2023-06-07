import 'package:test_project_insta_clone/enums/date_sorting.dart';
import 'package:test_project_insta_clone/state/comments/models/comment.dart';
import 'package:test_project_insta_clone/state/comments/models/post_comment_request.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForPostAndComment request) {
    if (request.sortByCreatedAt) {
      final sortedDocuments = toList()
        ..sort((a, b) {
          switch (request.order) {
            case DateSorting.newestOnTop:
              return b.createdAt.compareTo(a.createdAt);
            case DateSorting.oldestOnTop:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sortedDocuments;
    } else {
      return this;
    }
  }
}
