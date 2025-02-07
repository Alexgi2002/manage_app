import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xFF2862f5);

class AppTheme {
  final int selectedColor;
  final bool isDark;

  AppTheme({this.selectedColor = 0, this.isDark = false});

  ThemeData theme() {
    return _theme(isDark);
  }

  ThemeData themeLight() {
    return _theme(false);
  }

  ThemeData themeDark() {
    return _theme(true);
  }

  ThemeData _theme(bool isDarkMode) {
    return ThemeData(
        colorSchemeSeed: colorPrimary,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          // elevation: 20,
        ),
    );
  }

  AppTheme copyWith({
    int? selectedColor,
    bool? isDark,
  }) {
    return AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDark: isDark ?? this.isDark,
    );
  }
}
