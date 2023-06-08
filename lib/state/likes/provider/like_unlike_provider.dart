import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/constants/firebase_collection_name.dart';
import 'package:test_project_insta_clone/state/constants/firebase_field_name.dart';
import 'package:test_project_insta_clone/state/likes/models/like.dart';
import 'package:test_project_insta_clone/state/likes/models/like_unlike_request.dart';

final likeDislikePostProvider =
    FutureProvider.family.autoDispose<bool, LikeUnlikeRequest>(
  (ref, request) async {
    final query = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(
          FirebaseFieldName.postId,
          isEqualTo: request.postId,
        )
        .where(FirebaseFieldName.userId, isEqualTo: request.likedBy)
        .get();
    // check if the user liked the post before
    final hasLiked = await query.then((snapshot) => snapshot.docs.isNotEmpty);
    if (hasLiked) {
      try {
        await query.then((snapshot) async {
          for (final doc in snapshot.docs) {
            await doc.reference.delete();
          }
        });
        return true;
      } catch (_) {
        return false;
      }
    } else {
      final like = Like(
        postId: request.postId,
        userId: request.likedBy,
        date: DateTime.now(),
      );
      try {
        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.likes)
            .add(like);

        return true;
      } on Exception catch (_) {
        return false;
      }
    }
  },
);
