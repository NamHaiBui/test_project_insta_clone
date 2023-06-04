import 'package:test_project_insta_clone/state/post_settings/constants/strings_for_post_settings.dart';

enum PostSettings {
  allowLikes(
    title: StringsForPostSetting.allowLikesTitle,
    description: StringsForPostSetting.allowLikesDescription,
    storageKey: StringsForPostSetting.allowLikesStorageKey,
  ),
  allowComments(
    title: StringsForPostSetting.allowCommentsTitle,
    description: StringsForPostSetting.allowCommentsDescription,
    storageKey: StringsForPostSetting.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;
  const PostSettings(
      {required this.title,
      required this.description,
      required this.storageKey});
}
