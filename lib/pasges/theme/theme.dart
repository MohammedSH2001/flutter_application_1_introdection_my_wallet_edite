import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xFFFFFFFF),
    primary: Color(0xFFf8f7fd),
    secondary: Color(0xFFFFFFFF),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color(0xFF032A39),
    primary: Color(0xFF1c1c1E),
    secondary: Color(0xFF64CCC5),
  ),
);