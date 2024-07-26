import "package:flutter/material.dart";

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.grey.shade200,
        primary: Colors.grey.shade200,
        secondary: Colors.grey.shade400));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: Colors.grey.shade700,
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade700));
