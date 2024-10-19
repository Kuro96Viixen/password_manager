import 'package:flutter/material.dart';
import 'package:password_manager/constants/routes.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/constants/themes.dart';
import 'package:password_manager/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void asyncMethod() async {
    await Utils.readAccounts();
  }

  @override
  Widget build(BuildContext context) {
    asyncMethod();

    return MaterialApp(
      title: Texts.title,
      themeMode: ThemeMode.dark,
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      onGenerateRoute: Routes.routes,
      initialRoute: Routes.accounts,
    );
  }
}
