import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_project_insta_clone/views/components/rich_text/link_text.dart';

import 'base_text.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({super.key, required this.texts, this.styleForAll});

  final TextStyle? styleForAll;
  final Iterable<BaseText> texts;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(baseText.style),
              recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
              // .. is Cascading Notation of which allowing execution of multiple methods on the same object
            );
          } else {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(baseText.style),
            );
          }
        }).toList(),
      ),
    );
  }
}
