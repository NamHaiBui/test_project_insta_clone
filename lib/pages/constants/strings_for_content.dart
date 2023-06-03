import 'package:flutter/foundation.dart';

@immutable
class StringsForContent {
  static const appName = 'Instant-gram!';
  static const welcomeToAppName = 'Welcome to ${StringsForContent.appName}';
  static const youHaveNoPosts =
      'You have not made a post yet. Press either the video-upload or the photo-upload buttons to the top of the screen in order to upload your first post!';
  static const noPostsAvailable =
      "Nobody seems to have made any posts yet. Why don't you take the first step and upload your first post?!";
  static const enterYourSearchTerm =
      'Enter your search term in order go get started. You can search in the description of all posts available in the system';

  static const createNewPost = 'Create New Post';
  static const pleaseWriteYourMessageHere = 'Please write your message here';

  static const noCommentsYet =
      'Nobody has commented on this post yet. You can change that though, and be the first person who comments!';

  static const enterYourSearchTermHere = 'Enter your search term here';
  static const comments = 'Comments';
  static const writeYourCommentHere = 'Write your comment here...';
  static const checkOutThisPost = 'Check out this post!';
  static const postDetails = 'Post Details';
  static const post = 'post';
  const StringsForContent._();
}
