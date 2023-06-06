import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/image_upload/notifier/image_upload_notifier.dart';
import 'package:test_project_insta_clone/state/image_upload/typedefs/is_loading.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
        (ref) => ImageUploadNotifier());
