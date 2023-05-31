import 'package:test_project_insta_clone/state/auth/models/auth_result.dart';

import '../../posts/typedefs/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/constants.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;

  bool get isAlreadyLoggedIn => userId != null;

  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';

  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [Constants.emailScope],
      clientId: // For web client
          "499360257834-mdjqlj4mic67spck3k4kjhvhfmkjmtb1.apps.googleusercontent.com",
    );
    final signInAccount = await googleSignIn.signIn();
    // If the user cancels the log in process then signInAccount will be null
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    // the credentials saved on GoogleAuth
    final oAuthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      // we send the authentication credentials to firebase to verify
      await FirebaseAuth.instance.signInWithCredential(
        oAuthCredentials,
      );
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithEmailAndPassword() async {
    throw UnimplementedError();
  }
}
