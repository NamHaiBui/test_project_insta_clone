import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project_insta_clone/pages/auth_page.dart';
import 'package:test_project_insta_clone/pages/main_page.dart';
import 'package:test_project_insta_clone/state/providers/auth_state_provider.dart';
import 'package:test_project_insta_clone/state/providers/is_loading_provider.dart';
import 'package:test_project_insta_clone/state/providers/is_logged_in_provider.dart';
import 'package:test_project_insta_clone/views/components/loading/loading_widget.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: true,
      home: Consumer(
        builder: (context, ref, child) {
          //
          ref.listen<bool>(
            isLoadingProvider,
            (previous, next) {
              if (next) {
                LoadingWidget.instance().show(context: context);
              } else {
                LoadingWidget.instance().hide();
              }
            },
          );
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
