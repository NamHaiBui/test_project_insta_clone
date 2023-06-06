import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project_insta_clone/state/post_settings/models/post_settings.dart';

/// StateNotifer has an objects, state, of which can be set with an variable, after such,
/// the provider can pick the changes up and relay it to the UI.
/// StateNotifier can notify the listeners that something has changed but not what has changed.
class PostSettingsNotifier extends StateNotifier<Map<PostSettings, bool>> {
  PostSettingsNotifier()
      : super(
          UnmodifiableMapView(
            {
              for (final setting in PostSettings.values) setting: true,
            },
          ),
        );
  void setSettings(
    PostSettings setting,
    bool value,
  ) {
    final existingValue = state[setting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.unmodifiable(
      Map.from(state)..[setting] = value,
    );
  }
}
