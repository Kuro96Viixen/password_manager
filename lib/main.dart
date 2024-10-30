import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/core/constants/themes.dart';
import 'package:password_manager/app/di/app_di.dart' as app_di;

void main() {
  app_di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider:
          app_di.navigationModulesDi<GoRouter>().routeInformationProvider,
      routeInformationParser:
          app_di.navigationModulesDi<GoRouter>().routeInformationParser,
      routerDelegate: app_di.navigationModulesDi<GoRouter>().routerDelegate,
      title: Texts.title,
      themeMode: ThemeMode.dark,
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
    );
  }
}
