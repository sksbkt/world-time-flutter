import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark());
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // colorScheme: ColorScheme.light(),
    colorSchemeSeed: Colors.redAccent,
    // appBarTheme: AppBarTheme(backgroundColor: Colors.red.shade700)
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkmode => themeMode == ThemeMode.dark;
  void toggleThemeMode(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    print(themeMode.toString());
    notifyListeners();
  }
}
