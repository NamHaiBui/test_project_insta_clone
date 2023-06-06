import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/pages/constants/strings_for_content.dart';
import 'package:test_project_insta_clone/state/image_upload/models/file_type.dart';
import 'package:test_project_insta_clone/state/image_upload/models/thumbnail_request.dart';
import 'package:test_project_insta_clone/state/image_upload/provider/image_uploader_provider.dart';
import 'package:test_project_insta_clone/state/post_settings/models/post_settings.dart';
import 'package:test_project_insta_clone/state/post_settings/providers/post_settings_provider.dart';
import 'package:test_project_insta_clone/state/providers/user_id_provider.dart';
import 'package:test_project_insta_clone/views/components/file_thumbnail_widget.dart';

class CreateNewPostPage extends StatefulHookConsumerWidget {
  const CreateNewPostPage({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  final File fileToPost;
  final FileType fileType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostPageState();
}

class _CreateNewPostPageState extends ConsumerState<CreateNewPostPage> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );
    final postSettings = ref.watch(postSettingProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () {
        postController.removeListener(listener);
      };
    }, [postController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringsForContent.createNewPost,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(
                      userIdProvider,
                    );
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text;
                    final isUploaded = await ref
                        .read(imageUploadProvider.notifier)
                        .upload(
                            file: widget.fileToPost,
                            fileType: widget.fileType,
                            message: message,
                            postSettings: postSettings,
                            userId: userId);
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FileThumbnailWidget(
            thumbnailRequest: thumbnailRequest,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: StringsForContent.pleaseWriteYourMessageHere,
              ),
              autofocus: true,
              maxLines: 10,
              controller: postController,
            ),
          ),
          ...PostSettings.values.map(
            (postSetting) => ListTile(
              title: Text(postSetting.title),
              subtitle: Text(postSetting.description),
              trailing: Switch(
                  value: postSettings[postSetting] ?? false,
                  onChanged: (isOn) {
                    ref
                        .read(postSettingProvider.notifier)
                        .setSettings(postSetting, isOn);
                  }),
            ),
          ),
        ],
      )),
    );
  }
}
