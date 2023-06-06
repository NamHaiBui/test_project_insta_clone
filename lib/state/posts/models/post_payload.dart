import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:test_project_insta_clone/state/image_upload/models/file_type.dart';
import 'package:test_project_insta_clone/state/post_settings/models/post_settings.dart';
import 'package:test_project_insta_clone/state/posts/models/post_key.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/user_id.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required double aspectRatio,
    required FileType fileType,
    required String fileUrl,
    required String message,
    required String originalFileStorageId,
    required Map<PostSettings, bool> postSettings,
    required String fileName,
    required String thumbnailStorageId,
    required String thumbnailUrl,
    required UserId userId,
  }) : super({
          PostKey.userId: userId,
          PostKey.message: message,
          PostKey.createdAt: FieldValue.serverTimestamp(),
          PostKey.thumbnailUrl: thumbnailUrl,
          PostKey.fileUrl: fileUrl,
          PostKey.fileType: fileType.name,
          PostKey.fileName: fileName,
          PostKey.aspectRatio: aspectRatio,
          PostKey.originalFileStorageId: originalFileStorageId,
          PostKey.thumbnailStorageId: thumbnailStorageId,
          PostKey.postSettings: {
            for (final postSetting in postSettings.entries)
              postSetting.key.storageKey: postSetting.value,
          }
        });
}
