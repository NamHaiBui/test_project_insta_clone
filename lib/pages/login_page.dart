import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';
import 'package:test_project_insta_clone/views/constants/app_colors.dart';
import 'package:test_project_insta_clone/views/login/constants/strings_for_login.dart';
import 'package:test_project_insta_clone/views/login/divider_with_margin.dart';
import 'package:test_project_insta_clone/views/login/google_login_widget.dart';
import 'package:test_project_insta_clone/views/login/login_view_signup_links.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringsForLogin.appName),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40.0),
                Text(StringsForLogin.welcomeToAppName,
                    style: Theme.of(context).textTheme.displaySmall),
                const DividerWithMargins(),
                Text(
                  StringsForLogin.logIntoYourAccount,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(height: 1.5),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                  ),
                  onPressed:
                      ref.read(authStateProvider.notifier).loginWithGoogle,
                  child: const GoogleLoginWidget(),
                ),
                const DividerWithMargins(),
                const LoginViewSignupLink(),
              ],
            ))));
  }
}
