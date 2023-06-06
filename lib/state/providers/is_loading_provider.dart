import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/image_upload/provider/image_uploader_provider.dart';
import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';

final isLoadingProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);

  return authState.isLoading || isUploadingImage;
});
