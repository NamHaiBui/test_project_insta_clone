import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project_insta_clone/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:test_project_insta_clone/state/comments/models/comment.dart';
import 'package:test_project_insta_clone/state/comments/models/post_comment_request.dart';
import 'package:test_project_insta_clone/state/comments/models/post_with_comments.dart';
import 'package:test_project_insta_clone/state/constants/firebase_collection_name.dart';
import 'package:test_project_insta_clone/state/constants/firebase_field_name.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';

final specificPostWithCommentsProvider = StreamProvider.family
    .autoDispose<PostWithComments, RequestForPostAndComment>(
  (ref, request) {
    final controller = StreamController<PostWithComments>();
    Post? post;
    Iterable<Comment>? comments;
    void notify() {
      final localPost = post;
      // there is no post
      if (localPost == null) {
        return;
      }

      final outputComments = (comments ?? []).applySortingFrom(request);
      final result =
          PostWithComments(post: localPost, comments: outputComments);
      controller.add(result);
    }

    //  watch changes to the post
    final postSub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.posts)
        .where(FieldPath.documentId,
            isEqualTo: request
                .postId) // posts collection used the postId as field path
        .limit(1)
        .snapshots()
        .listen((event) {
      if (event.docs.isEmpty) {
        // There is no such post so everything is null
        post = null;
        comments = null;
        notify();
        return;
      }
      final doc = event.docs.first;
      if (doc.metadata.hasPendingWrites) {
        // still being written on the server
        return;
      }
      post = Post(postId: doc.id, json: doc.data());
      notify();
    });
    //  watch changes to the comments
    final commentsQuery = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.comments,
        )
        .where(FirebaseFieldName.postId, isEqualTo: request.postId);
    // .orderBy(FirebaseFieldName.createdAt, descending: true);

    final limitedCommentQuery = request.limit != null
        ? commentsQuery.limit(request.limit ?? 5)
        : commentsQuery;
    final commentsSub = limitedCommentQuery.snapshots().listen((event) {
      comments = event.docs
          .where((doc) => !doc.metadata.hasPendingWrites)
          .map((e) => Comment(e.data(), id: e.id));
      notify();
    });
    ref.onDispose(() {
      postSub.cancel();
      commentsSub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
