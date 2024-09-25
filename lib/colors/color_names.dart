// color_names.dart
import 'package:flutter/material.dart';

class ColorNames {
  static const Map<String, Color> colorMap = {
    'Orange': Color(0xFFE85C0D),
  };

  static Color getColorByName(String colorName) {
    return colorMap[colorName] ?? Colors.black; // Default to black if not found
  }
}
