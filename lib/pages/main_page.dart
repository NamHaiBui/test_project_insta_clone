import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('MainView')), actions: [
        TextButton.icon(
            onPressed: () {
              ref.read(authStateProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout')),
      ]),
    );
  }
}
