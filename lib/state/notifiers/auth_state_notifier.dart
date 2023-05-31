import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:test_project_insta_clone/state/auth/backend/authenticator.dart";
import "package:test_project_insta_clone/state/auth/models/auth_result.dart";

import "package:test_project_insta_clone/state/auth/models/auth_state.dart";

import "../posts/typedefs/user_id.dart";
import "../user_info/backend/user_info_storage.dart";

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  Future<void> logout() async {
    state = state.copiedWithIsLoadin(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoadin(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> saveUserInfo({required UserId userId}) {
    return _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email);
  }
}
