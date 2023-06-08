import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project_insta_clone/state/constants/firebase_collection_name.dart';
import 'package:test_project_insta_clone/state/constants/firebase_field_name.dart';
import 'package:test_project_insta_clone/state/posts/models/post.dart';
import 'package:test_project_insta_clone/state/posts/models/post_key.dart';
import 'package:test_project_insta_clone/state/providers/user_id_provider.dart';

// final firestore = FirebaseFirestore.instance;
// Provide information on the user's posts
// as soon as if no one is using autoDispose will dispose the provider
final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<Post>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .orderBy(
          FirebaseFieldName.createdAt,
          descending: true,
        )
        .where(
          PostKey.userId,
          isEqualTo: userId,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;
        final posts = documents
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Post(
                postId: doc.id,
                json: doc.data(),
              ),
            );
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
