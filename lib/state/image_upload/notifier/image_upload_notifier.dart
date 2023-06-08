import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/constants/firebase_collection_name.dart';
import 'package:test_project_insta_clone/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:test_project_insta_clone/state/posts/models/post_payload.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:test_project_insta_clone/state/image_upload/constants/constants.dart';
import 'package:test_project_insta_clone/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:test_project_insta_clone/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:test_project_insta_clone/state/image_upload/models/file_type.dart';
import 'package:test_project_insta_clone/state/image_upload/typedefs/is_loading.dart';
import 'package:test_project_insta_clone/state/post_settings/models/post_settings.dart';
import 'package:test_project_insta_clone/state/posts/typedefs/user_id.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSettings, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8List;
    switch (fileType) {
      case FileType.image:
        //
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          return false;
        }
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);

        break;
      case FileType.video:
        final thumbnail = await VideoThumbnail.thumbnailData(
            video: file.path,
            imageFormat: ImageFormat.JPEG,
            maxHeight: Constants.videoThumbnailQuality);
        if (thumbnail == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8List = thumbnail;
        }
        break;
    }
    // calculate the aspect ratio
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();
    // calculate references
    final fileName = const Uuid().v4();
    // create references to the thumbnail and the image itself
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);
    try {
      // upload the thumbnail
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;
      // upload the original file
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;
      // upload the post itself
      final postPayload = PostPayload(
          aspectRatio: thumbnailAspectRatio,
          fileType: fileType,
          fileUrl: await originalFileRef.getDownloadURL(),
          message: message,
          originalFileStorageId: originalFileStorageId,
          postSettings: postSettings,
          fileName: fileName,
          thumbnailStorageId: thumbnailStorageId,
          thumbnailUrl: await thumbnailRef.getDownloadURL(),
          userId: userId);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
