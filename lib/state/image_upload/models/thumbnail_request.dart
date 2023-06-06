import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:test_project_insta_clone/state/image_upload/models/file_type.dart';

@immutable
class ThumbnailRequest {
  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  final File file;
  final FileType fileType;

  /// You need to build an equality operation for new objects for the provider
  /// In the case when the provider provides a new state and compare it, it may not be an exact match and hence will enter an infinite loop
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThumbnailRequest &&
          runtimeType == other.runtimeType &&
          file == other.file &&
          fileType == other.fileType;

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        file,
        fileType,
      ]);
}
