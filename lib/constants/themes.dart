import 'package:flutter/material.dart';

class CustomThemes {
  static ThemeData lightTheme = ThemeData();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Verdana',
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.purple[200]!,
      onPrimary: Colors.purple,
      secondary: Colors.purple[200]!,
      onSecondary: Colors.purple,
      error: Colors.red,
      onError: Colors.grey[500]!,
      background: Colors.grey[850]!,
      onBackground: Colors.purple[300]!,
      surface: Colors.grey[800]!,
      onSurface: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[800]!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
        ),
      ),
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[200]!,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16.0,
        ),
        minimumSize: const Size(
          200.0,
          40.0,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.grey[800]!,
      foregroundColor: Colors.purple[200]!,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.purple[200]!,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[900]!,
      foregroundColor: Colors.purple[200]!,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Colors.purple[200]!),
      trackColor: const MaterialStatePropertyAll(Colors.transparent),
      trackOutlineColor: MaterialStatePropertyAll(Colors.purple[200]!),
      splashRadius: 0.0,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: const MaterialStatePropertyAll(Colors.white),
      fillColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? Colors.purple[200]!
            : Colors.transparent,
      ),
    ),
  );
}
