import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letreiro_digital/app/core/ui/theme/theme_config.dart';
import 'package:localization/localization.dart';

import 'core/store/theme_store.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var themeStore = ThemeModeWidget.of(context);
    var themeMode = themeStore.value;
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return MaterialApp.router(
      title: 'MNUC',
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        LocalJsonLocalization.delegate
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      theme: ThemeConfig.themeLight,
      darkTheme: ThemeConfig.themeDark,
      themeMode: themeMode,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
