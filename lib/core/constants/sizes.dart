import 'package:flutter/material.dart';

class AppTextSizes {
  /// TITLE_1 TEXT STYLE
  ///
  /// Font-Size: 20
  /// Font-Weight: Bold
  static const String title1 = 'TITLE_1';

  /// TITLE_2 TEXT STYLE
  ///
  /// Font-Size: 18
  /// Font-Weight: Bold
  static const String title2 = 'TITLE_2';

  /// TITLE_3 TEXT STYLE
  ///
  /// Font-Size: 18
  /// Font-Weight: Bold
  static const String title3 = 'TITLE_3';

  /// BODY_TEXT_1 TEXT STYLE
  ///
  /// Font-Size: 14
  /// Font-Weight: Bold
  static const String bodyText1 = 'BODY_TEXT_1';

  /// BODY_TEXT_2 TEXT STYLE
  ///
  /// Font-Size: 12
  /// Font-Weight: Bold
  static const String bodyText2 = 'BODY_TEXT_2';

  /// BODY_TEXT_2 TEXT STYLE
  ///
  /// Font-Size: 12
  /// Font-Weight: Normal
  static const String bodyText3 = 'BODY_TEXT_3';

  /// HEADLINE_TEXT_1 TEXT STYLE
  ///
  /// Font-Size: 64
  /// Font-Weight: Bold
  static const String headline1 = 'HEADLINE_1';

  /// HEADLINE_TEXT_2 TEXT STYLE
  ///
  /// Font-Size: 56
  /// Font-Weight: Bold
  static const String headline2 = 'HEADLINE_2';

  /// HEADLINE_TEXT_3 TEXT STYLE
  ///
  /// Font-Size: 48
  /// Font-Weight: Bold
  static const String headline3 = 'HEADLINE_3';

  /// HEADLINE_TEXT_4 TEXT STYLE
  ///
  /// Font-Size: 28
  /// Font-Weight: Bold
  static const String headline4 = 'HEADLINE_4';

  /// HEADLINE_TEXT_5 TEXT STYLE
  ///
  /// Font-Size: 24
  /// Font-Weight: Bold
  static const String headline5 = 'HEADLINE_5';
}

class AppSizes {
  /// HORIZONTAL SIZE
  ///
  /// This size is used to apply a horizontal space to both screen properties.
  static const double horizontal_1 = 1;
  static const double horizontal_2 = 2;
  static const double horizontal_3 = 3;
  static const double horizontal_4 = 4;
  static const double horizontal_5 = 5;
  static const double horizontal_6 = 6;
  static const double horizontal_7 = 7;
  static const double horizontal_8 = 8;
  static const double horizontal_9 = 9;
  static const double horizontal_10 = 10;
  static const double horizontal_11 = 11;
  static const double horizontal_12 = 12;
  static const double horizontal_13 = 13;
  static const double horizontal_14 = 14;
  static const double horizontal_15 = 15;
  static const double horizontal_16 = 16;
  static const double horizontal_17 = 17;
  static const double horizontal_18 = 18;
  static const double horizontal_19 = 19;
  static const double horizontal_20 = 20;
  static const double horizontal_25 = 25;
  static const double horizontal_30 = 30;
  static const double horizontal_35 = 35;

  /// VERTICAL SIZE
  ///
  /// This size is used to apply a vertical space to both screen properties.
  static const double vertical_1 = 1;
  static const double vertical_2 = 2;
  static const double vertical_3 = 3;
  static const double vertical_4 = 4;
  static const double vertical_5 = 5;
  static const double vertical_6 = 6;
  static const double vertical_7 = 7;
  static const double vertical_8 = 8;
  static const double vertical_9 = 9;
  static const double vertical_10 = 10;
  static const double vertical_12 = 12;
  static const double vertical_13 = 13;
  static const double vertical_14 = 14;
  static const double vertical_15 = 15;
  static const double vertical_16 = 16;
  static const double vertical_17 = 17;
  static const double vertical_18 = 18;
  static const double vertical_19 = 19;
  static const double vertical_20 = 20;
  static const double vertical_25 = 25;
  static const double vertical_30 = 30;
  static const double vertical_40 = 40;
  static const double vertical_45 = 45;
  static const double vertical_50 = 50;
  static const double vertical_60 = 60;
  static const double vertical_70 = 70;
  static const double vertical_80 = 80;
  static const double vertical_90 = 90;
  static const double vertical_100 = 100;

  /// Width of current context
  ///
  /// MediaQuery.of(context).size.width;
  ///
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Height of current context
  ///
  /// MediaQuery.of(context).size.height;
  ///
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
