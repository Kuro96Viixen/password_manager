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

  @override
  Widget build(BuildContext context) {
    Utils.readAccounts();

    return MaterialApp(
      title: Texts.title,
      darkTheme: CustomThemes.darkTheme,
      theme: ThemeData(
        fontFamily: 'Verdana',
      ),
      onGenerateRoute: Routes.routes,
      initialRoute: Routes.accounts,
    );
  }
}
