// This is a singleton
import 'dart:async';
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:test_project_insta_clone/views/components/constants/strings.dart';

import 'loading_widget_controller.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class LoadingWidget {
  LoadingWidget._sharedInstance();
  static final LoadingWidget _shared = LoadingWidget._sharedInstance();
  factory LoadingWidget.instance() => _shared;
  LoadingWidgetController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingWidgetController? showOverlay(
      {required BuildContext context, required String text}) {
    final textController = StreamController<String>();
    final state = Overlay.of(context);

    textController.add(text);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    size.log();
    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: size.width * 0.8,
                  maxHeight: size.height * 0.8,
                  minWidth: size.width * 0.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<String>(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.requireData,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black));
                          } else {
                            return Container();
                          }
                        },
                        stream: textController.stream,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    state.insert(overlay);
    return LoadingWidgetController(close: () {
      textController.close();
      overlay.remove();

      return true;
    }, update: (String text) {
      textController.add(text);
      return true;
    });
  }
}
