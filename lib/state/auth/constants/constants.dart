import 'package:flutter/foundation.dart';

/// error
/// - For when the program fails to verify user with google sign in
/// - If there exists another account with the same credentials
///
/// Email Scope, Sign in with google
///
@immutable
class Constants {
  static const accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';
  const Constants._();
}
