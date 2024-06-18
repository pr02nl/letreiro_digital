import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/services/local_store/local_shared_preferences.dart';
import 'app/core/store/theme_store.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: ThemeModeWidget(
        notifier: ThemeStore(
          LocalSharedPreferences(),
        ),
        child: const RxRoot(child: AppWidget()),
      ),
    ),
  );
}
