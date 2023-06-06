import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:test_project_insta_clone/state/image_upload/extensions/get_image_aspect_ratio.dart';
import 'package:test_project_insta_clone/state/image_upload/models/file_type.dart';
import 'package:test_project_insta_clone/state/image_upload/models/image_with_aspect_ratio.dart';
import 'package:test_project_insta_clone/state/image_upload/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

///Family Provider modifier has one purpose: Getting a unique provider based on external parameters:
///Some common use-cases for family:
///- Combining FutureProvider with .family to fetch a Message from its ID
///- Passing the current Locale to a provider, so we can hanfle translations
/// TLDR: It allows sending values to the provider as with the usual provider we can only read from
//<State, Arg>

final thumbnailProvider =
    FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
  (ref, ThumbnailRequest request) async {
    final Image image;
    switch (request.fileType) {
      case FileType.image:
        image = Image.file(
          request.file,
          fit: BoxFit.fitHeight,
        );
        break;
      case FileType.video:
        final thumbnail = await VideoThumbnail.thumbnailData(
          video: request.file.path,
          imageFormat: ImageFormat.JPEG,
          quality: 75,
        );
        if (thumbnail == null) {
          throw const CouldNotBuildThumbnailException();
        } else {
          image = Image.memory(
            thumbnail,
            fit: BoxFit.fitHeight,
          );
        }
        break;
    }

    final aspectRatio = await image.getAspectRatio();
    return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
  },
);
