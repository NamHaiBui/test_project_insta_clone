import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// when we pick a file on the system, it will return an XFile of which we will have to convert to a File that we can use
///
extension ToFile on Future<XFile?> {
  Future<File?> toFile() => then((xFile) => xFile?.path)
      .then((filePath) => filePath != null ? File(filePath) : null);
}
