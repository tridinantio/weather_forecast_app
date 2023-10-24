import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = "#03091C".toColor();
  static Color secondary = "#262F4B".toColor();
  static Color white = "#FFFFFF".toColor();
  static Color pink = "#EA887B".toColor();
  static Color purple = "#CE92E3".toColor();
  static Color black60 = "#737D9C".toColor();
  static Color black = "#5B6279".toColor();
  static Color black30 = "#8D93AB".toColor();
  static Color grey = "#D9D9D9".toColor();
  static Color grey60 = "#A9A9AC".toColor();
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
