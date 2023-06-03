import 'package:flutter/material.dart';
import 'package:test_project_insta_clone/views/components/rich_text/base_text.dart';
import 'package:test_project_insta_clone/views/login/constants/strings_for_login.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/rich_text/rich_text_widget.dart';

class LoginViewSignupLink extends StatelessWidget {
  const LoginViewSignupLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll:
          Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(
          text: StringsForLogin.dontHaveAnAccount,
        ),
        BaseText.plain(
          text: StringsForLogin.signUpOn,
        ),
        BaseText.link(
            text: StringsForLogin.google,
            onTapped: () {
              launchUrl(Uri.parse(StringsForLogin.googleSignupUrl));
            })
      ],
    );
  }
}
