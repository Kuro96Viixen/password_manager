import 'package:flutter/material.dart';

class CustomThemes {
  static ThemeData lightTheme = ThemeData();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Verdana',
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      // Main color
      primary: Colors.purple[200]!,
      // Color for errors
      error: Colors.red,
      // Background color
      surface: Colors.grey[800]!,
      // Colors of items in screen
      onSurface: Colors.white,
      // Unused but required
      onPrimary: Colors.black,
      secondary: Colors.black,
      onSecondary: Colors.black,
      onError: Colors.black,
    ),
    listTileTheme: const ListTileThemeData(),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[800],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(minWidth: double.infinity),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[200],
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
        minimumSize: const Size(200, 40),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.grey[850],
      foregroundColor: Colors.purple[200],
      scrolledUnderElevation: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.purple[200],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.purple[200],
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(Colors.purple[200]),
      trackColor: const WidgetStatePropertyAll(Colors.transparent),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.white),
      splashRadius: 0,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: const WidgetStatePropertyAll(Colors.white),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? Colors.purple[200]!
            : Colors.transparent,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.white24,
    ),
  );
}
