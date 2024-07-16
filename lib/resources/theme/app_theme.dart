import 'package:flutter/material.dart';

final colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xff293798),
  onPrimary: Colors.white,
  secondary: const Color(0xffff5896),
  onSecondary: Colors.white,
  error: Colors.redAccent,
  onError: Colors.redAccent[200]!,
  background: Colors.white,
  onBackground: Colors.black87,
  surface: Colors.white,
  onSurface: Colors.black87,
);

final buttonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.secondary,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      fixedSize: const Size.fromHeight(45),
      foregroundColor: colorScheme.onSecondary,
      textStyle: const TextStyle(fontSize: 16)),
);

final floatingButtonTheme =
    FloatingActionButtonThemeData(backgroundColor: colorScheme.secondary);

final appBarTheme = AppBarTheme(
  backgroundColor: colorScheme.primary,
  centerTitle: false,
  foregroundColor: Colors.white,
);

