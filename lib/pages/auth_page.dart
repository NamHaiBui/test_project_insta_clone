import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as devtools show log;

import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class AuthPage extends ConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Auth Page')),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () async {
                ref.read(authStateProvider.notifier).loginWithGoogle();
              },
              child: const Text(
                'Sign In with Google',
              ),
            ),
          ],
        ));
  }
}
