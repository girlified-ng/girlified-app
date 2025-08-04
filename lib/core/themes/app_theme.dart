import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primaryColor,
  onPrimary: AppColors.whiteColor,
  secondary: AppColors.buttonPrimaryColor,
  onSecondary: AppColors.whiteColor,
  error: Colors.red,
  onError: AppColors.whiteColor,
  surface: AppColors.whiteColor,
  onSurface: AppColors.textColor,
);

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.darkThemePrimaryColor,
  onPrimary: AppColors.whiteColor,
  secondary: AppColors.darkThemeButtonPrimaryColor,
  onSecondary: AppColors.whiteColor,
  error: Colors.red,
  onError: AppColors.whiteColor,
  surface: AppColors.whiteColor,
  onSurface: AppColors.darkThemeTextColor,
);

final ThemeData lightModeTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.buttonPrimaryColor,
    disabledColor: AppColors.buttonPrimaryDisabledColor,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 64.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading 5XL
    displayMedium: TextStyle(
      fontSize: 56.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading 4XL

    headlineLarge: TextStyle(
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading 3XL
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading 2XL
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading XL

    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading L
    // Smaller Headings
    titleMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading M
    titleSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading S

    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading XS
    bodyMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ), // Heading 2XS
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppColors.textColor,
    ), // Text XS Regular

    labelSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppColors.textColor,
    ), // Text XS Medium
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.appBarBackgroundColor,
  ),
  useMaterial3: true,
  fontFamily: 'Inter',
);

final ThemeData darkModeTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  primaryColor: AppColors.darkThemePrimaryColor,
  scaffoldBackgroundColor: AppColors.darkThemeBackgroundColor,
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.darkThemeButtonPrimaryColor,
    disabledColor: AppColors.darkThemeButtonPrimaryDisabledColor,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 64.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading 5XL
    displayMedium: TextStyle(
      fontSize: 56.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading 4XL
    headlineLarge: TextStyle(
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading 3XL
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading 2XL
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading XL

    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading L
    titleMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading M
    titleSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading S

    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading XS
    bodyMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkThemeTextColor,
    ), // Heading 2XS
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppColors.darkThemeTextColor,
    ), // Text XS Regular

    labelSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppColors.darkThemeTextColor,
    ), // Text XS Medium
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkThemeAppBarBackgroundColor,
  ),
  useMaterial3: true,
  fontFamily: 'Inter',
);
