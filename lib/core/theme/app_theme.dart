import "package:flutter/material.dart";

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        shadow: const Color.fromARGB(255, 195, 194, 194),
        surface: Colors.white,
        primary: Colors.grey.shade200,
        secondary: const Color.fromARGB(255, 214, 232, 215)));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        shadow: Colors.black,
        surface: Colors.grey.shade700,
        surfaceDim: const Color.fromARGB(255, 113, 155, 124),
        primary: Colors.grey.shade800,
        secondary: Colors.black));
