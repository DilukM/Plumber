import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../theme.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: AppTheme.colors.primary,
    side: BorderSide(color: AppTheme.colors.primary),
    padding: const EdgeInsets.symmetric(
      vertical: 18,
    ),
    textStyle: TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: AppTheme.colors.primary,
    side: BorderSide(color: AppTheme.colors.primary),
    padding: const EdgeInsets.symmetric(vertical: 18),
    textStyle: TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));
}
