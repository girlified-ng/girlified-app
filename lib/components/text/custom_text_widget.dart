// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final String? textStyleName;
  Color? color;
  double? size;
  int? maxLines;
  double? lineHeight;
  double? letterSpacing;
  FontWeight? weight;
  TextDecoration? decoration;
  Color? decorationColor;
  double? decorationThickness;
  TextAlign? alignment;
  FontStyle? fontStyle;
  String? fontFamily;

  /// A custom widget displays text extending the default flutter Text widget
  CustomTextWidget({
    super.key,
    this.color,
    this.size,
    this.maxLines,
    this.weight,
    this.decoration,
    this.fontFamily,
    this.fontStyle,
    this.decorationColor,
    this.decorationThickness,
    this.lineHeight,
    this.letterSpacing,
    this.alignment,
    required this.text,
    this.textStyleName,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? baseStyle;

    // Get the base style from the theme
    switch (textStyleName) {
      case AppTextSizes.headline1:
        baseStyle = Theme.of(context).textTheme.displayLarge;
        break;
      case AppTextSizes.headline2:
        baseStyle = Theme.of(context).textTheme.displayMedium;
        break;
      case AppTextSizes.headline3:
        baseStyle = Theme.of(context).textTheme.headlineLarge;
        break;
      case AppTextSizes.headline4:
        baseStyle = Theme.of(context).textTheme.headlineMedium;
        break;
      case AppTextSizes.headline5:
        baseStyle = Theme.of(context).textTheme.headlineSmall;
        break;
      case AppTextSizes.title1:
        baseStyle = Theme.of(context).textTheme.titleLarge;
        break;
      case AppTextSizes.title2:
        baseStyle = Theme.of(context).textTheme.titleMedium;
        break;
      case AppTextSizes.title3:
        baseStyle = Theme.of(context).textTheme.titleSmall;
        break;
      case AppTextSizes.bodyText1:
        baseStyle = Theme.of(context).textTheme.bodyLarge;
        break;
      case AppTextSizes.bodyText2:
        baseStyle = Theme.of(context).textTheme.bodyMedium;
        break;
      case AppTextSizes.bodyText3:
        baseStyle = Theme.of(context).textTheme.bodySmall;
        break;
      default:
        baseStyle = Theme.of(context).textTheme.labelSmall;
    }

    return Text(
      text,
      maxLines: maxLines ?? 6,
      textAlign: alignment ?? TextAlign.left,
      style: baseStyle?.copyWith(
          color: color,
          fontSize: size,
          fontWeight: weight,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationThickness: decorationThickness,
          height: lineHeight,
          fontStyle: fontStyle,
          fontFamily: fontFamily,
          letterSpacing: letterSpacing ?? 0),
    );
  }
}
