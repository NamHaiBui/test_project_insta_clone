import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_project_insta_clone/pages/login_page.dart';
import 'package:test_project_insta_clone/pages/main_page.dart';
import 'package:test_project_insta_clone/state/providers/is_loading_provider.dart';
import 'package:test_project_insta_clone/views/components/loading/loading_widget.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
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
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingWidget.instance().show(context: context);
              } else {
                LoadingWidget.instance().hide();
              }
            },
          );
          return MaterialApp(
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? '/login'
                : '/main-page',
            routes: {
              '/login': (context) => const LoginPage(),
              '/main-page': (context) => MainPage(key: key),
            },
          );
        },
      ),
    );
  }
}
