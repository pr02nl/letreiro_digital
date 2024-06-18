import 'package:flutter/material.dart';

class ThemeConfig {
  ThemeConfig._();
  static final themeLight = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  ).copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
  );
  static final themeDark = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
