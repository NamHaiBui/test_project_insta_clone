import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/image_upload/models/thumbnail_request.dart';
import 'package:test_project_insta_clone/state/image_upload/provider/thumbnail_provider.dart';
import 'package:test_project_insta_clone/views/components/animations/loading_animation_view.dart';
import 'package:test_project_insta_clone/views/components/animations/small_error_animation_view.dart';

class FileThumbnailWidget extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailWidget({super.key, required this.thumbnailRequest});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbnail.when(data: (imageWithAspectRatio) {
      return AspectRatio(
        aspectRatio: imageWithAspectRatio.aspectRatio,
        child: imageWithAspectRatio.image,
      );
    }, error: (_, __) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const LoadingAnimationView();
    });
  }
}
