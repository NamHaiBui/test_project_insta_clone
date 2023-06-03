import 'package:flutter/foundation.dart';

@immutable
class StringsForLogin {
  static const appName = 'Instant-gram!';
  static const welcomeToAppName = 'Welcome to ${StringsForLogin.appName}';
  static const google = 'Google';
  static const googleSignupUrl = 'https://accounts.google.com/signup';
  static const logIntoYourAccount =
      'Log into your account using one of the options below.';

  // login view rich text at bottom
  static const dontHaveAnAccount = "Don't have an account?\n";
  static const signUpOn = 'Sign up on ';
  static const orCreateAnAccountOn = ' or create an account on ';

  const StringsForLogin._();
}
