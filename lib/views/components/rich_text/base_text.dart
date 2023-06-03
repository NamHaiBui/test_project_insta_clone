import 'package:flutter/material.dart';
import 'package:test_project_insta_clone/views/components/rich_text/link_text.dart';

@immutable
class BaseText {
  const BaseText({required this.text, this.style});
// OOP: parent classes can return an instance of its subclasses
  factory BaseText.link({
    required String text,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
    required onTapped,
  }) =>
      LinkText(
        text: text,
        style: style,
        onTapped: onTapped,
      );

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(text: text, style: style);

  final TextStyle? style;
  final String text;
}
