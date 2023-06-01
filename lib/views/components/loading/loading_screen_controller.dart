import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
// transfer to the loading screen when we close certain functions
  final CloseLoadingScreen close;
// transfer to the loading screen when we get any updates
  final UpdateLoadingScreen update;

  const LoadingScreenController({required this.close, required this.update});
}
