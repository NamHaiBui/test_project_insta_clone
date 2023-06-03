import 'package:flutter/material.dart' show Colors, immutable;
import 'package:test_project_insta_clone/extensions/string/as_html_color_to_color.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.htmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.htmlColorToColor();
  const AppColors._();
}
