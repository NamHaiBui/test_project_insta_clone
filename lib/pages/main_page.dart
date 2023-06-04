import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/pages/constants/strings_for_content.dart';
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
                  onPressed: () async {},
                  icon: const FaIcon(
                    FontAwesomeIcons.film,
                  ),
                ),
                IconButton(
                  onPressed: () async {},
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
