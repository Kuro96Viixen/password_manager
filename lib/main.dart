import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/themes.dart';
import 'package:password_manager/app/di/app_di.dart' as app_di;
import 'package:password_manager/l10n/app_localizations.dart';

void main() {
  app_di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device language setting via PlatformDispatcher
    final deviceLocale = PlatformDispatcher.instance.locale;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp.router(
      routeInformationProvider: app_di
          .navigationModulesDi<GoRouter>()
          .routeInformationProvider,
      routeInformationParser: app_di
          .navigationModulesDi<GoRouter>()
          .routeInformationParser,
      routerDelegate: app_di.navigationModulesDi<GoRouter>().routerDelegate,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
      themeMode: ThemeMode.dark,
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      locale: deviceLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
