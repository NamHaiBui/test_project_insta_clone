import 'package:flutter/material.dart' show immutable;

@immutable
class FirebaseCollectionName {
  const FirebaseCollectionName._();

  static const thumbnails = 'thumbnails';
  static const comments = 'comments';
  static const likes = 'likes';
  static const posts = 'posts';
  static const users = 'users';
}
