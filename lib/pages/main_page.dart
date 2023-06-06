import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/pages/constants/strings_for_content.dart';
import 'package:test_project_insta_clone/pages/create_new_post_page.dart';
import 'package:test_project_insta_clone/state/image_upload/helpers/image_picker_helper.dart';
import 'package:test_project_insta_clone/state/image_upload/models/file_type.dart';
import 'package:test_project_insta_clone/state/post_settings/providers/post_settings_provider.dart';
import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';
import 'package:test_project_insta_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:test_project_insta_clone/views/components/dialogs/logout_dialog.dart';
import 'package:test_project_insta_clone/views/tabs/users_posts/user_posts_widget.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              title: const Text(
                StringsForContent.appName,
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    final videoFile =
                        await ImagePickerHelper.pickVideoFromGallery();
                    if (videoFile == null) {
                      return;
                    }
                    // ignore: unused_result
                    ref.refresh(postSettingProvider);
                    // go to the screen to create a new post
                    if (!mounted) {
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return CreateNewPostPage(
                            fileToPost: videoFile,
                            fileType: FileType.video,
                          );
                        },
                      ),
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.film,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    //pick an Image
                    final imageFile =
                        await ImagePickerHelper.pickVideoFromGallery();
                    if (imageFile == null) {
                      return;
                    }
                    // ignore: unused_result
                    ref.refresh(postSettingProvider);
                    // go to the screen to create a new post
                    if (!mounted) {
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return CreateNewPostPage(
                            fileToPost: imageFile,
                            fileType: FileType.image,
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                ),
                IconButton(
                  onPressed: () async {
                    final agreeToLogOut = await LogoutDialog()
                        .present(context)
                        .then((value) => value ?? false);
                    if (agreeToLogOut) {
                      ref.read(authStateProvider.notifier).logout();
                    }
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.person,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.home,
                    ),
                  )
                ],
              )),
          body: const TabBarView(children: [
            UserPostWidget(),
            UserPostWidget(),
            UserPostWidget(),
          ])),
    );
  }
}
