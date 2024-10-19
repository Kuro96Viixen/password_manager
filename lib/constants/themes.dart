import 'package:flutter/material.dart';

class CustomThemes {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.purple[300]!,
      onPrimary: Colors.purple[300]!,
      secondary: ThemeData.dark().colorScheme.surface,
      onSecondary: Colors.purple[300]!,
      error: ThemeData.dark().colorScheme.error,
      onError: ThemeData.dark().colorScheme.onError,
      background: Colors.indigo,
      onBackground: Colors.orange,
      surface: ThemeData.dark().colorScheme.surface,
      onSurface: Colors.purple[300]!,
    ),
    // toggleableActiveColor: Colors.purple[300]!,
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Verdana',
        ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Verdana',
        ),
  );
}
