import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingWidget = bool Function();
typedef UpdateLoadingWidget = bool Function(String text);

@immutable
class LoadingWidgetController {
// transfer to the loading screen when we close certain functions
  final CloseLoadingWidget close;
// transfer to the loading screen when we get any updates
  final UpdateLoadingWidget update;

  const LoadingWidgetController({required this.close, required this.update});
}
