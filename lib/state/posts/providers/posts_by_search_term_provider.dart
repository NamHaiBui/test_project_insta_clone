import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/constants/firebase_collection_name.dart';
import 'package:test_project_insta_clone/state/constants/firebase_field_name.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/search_term.dart';

final postsBySearchTermProvider =
    StreamProvider.family.autoDispose<Iterable<Post>, SearchTerm>(
  (ref, searchTerm) {
    final controller = StreamController<Iterable<Post>>();
    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .orderBy(FirebaseFieldName.createdAt, descending: true)
        .snapshots()
        .listen(
      (event) {
        final posts = event.docs.map((doc) {
          return Post(
            json: doc.data(),
            postId: doc.id,
          );
        }).where((post) => post.message.toLowerCase().contains(
              searchTerm.toLowerCase(),
            ));
        controller.add(posts);
      },
    );
    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
