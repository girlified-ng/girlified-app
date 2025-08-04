import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:girlified/core/themes/app_theme.dart';

class ThemeProvider extends GetxController {
  final _themeData = lightModeTheme.obs;

  ThemeData get themeData => _themeData.value;

  void setThemeData(ThemeData theme) {
    _themeData.value = theme;
  }

  void toggleTheme() {
    if (_themeData.value == lightModeTheme) {
      _themeData.value = darkModeTheme;
    } else {
      _themeData.value = lightModeTheme;
    }
  }
}
