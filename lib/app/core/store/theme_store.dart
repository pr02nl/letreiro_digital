import 'package:flutter/material.dart';

import '../services/local_store/local_storage.dart';

class ThemeStore extends ValueNotifier<ThemeMode> {
  static const _themeModeKey = "themeModeKey";
  final LocalStorage storage;

  ThemeStore(this.storage) : super(ThemeMode.system) {
    loadTheme();
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    value = themeMode;
    await storage.put(_themeModeKey, value.name);
  }

  Future<void> loadTheme() async {
    var name = await storage.get(_themeModeKey);
    value = ThemeMode.values.firstWhere(
      (e) => e.name == name,
      orElse: () => ThemeMode.system,
    );
  }
}

class ThemeModeWidget extends InheritedNotifier<ThemeStore> {
  const ThemeModeWidget(
      {super.key, required super.child, required super.notifier});
  static ThemeStore of(BuildContext context) {
    var themeModeWidget =
        context.dependOnInheritedWidgetOfExactType<ThemeModeWidget>()!;
    return themeModeWidget.notifier!;
  }
}
