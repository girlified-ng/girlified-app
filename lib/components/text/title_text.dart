import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/custom_text_widget.dart';

class TitleText extends StatelessWidget {
  final String title;
  final double? size;
  final int? maxLines;
  final Color? color;
  final String? fontFamily;
  final FontWeight? weight;
  final double? letterSpacing;
  final TextAlign? alignment;
  final Color? decorationColor;
  final TextDecoration? decoration;
  const TitleText(
      {super.key,
      this.size = 16,
      this.maxLines,
      this.decoration,
      this.decorationColor,
      this.letterSpacing = -1,
      this.fontFamily = 'SF Pro',
      this.weight = FontWeight.w500,
      this.alignment = TextAlign.left,
      this.color = AppColors.blackColor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      size: size,
      text: title,
      color: color,
      weight: weight,
      maxLines: maxLines,
      alignment: alignment,
      decoration: decoration,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      decorationColor: decorationColor,
      textStyleName: AppTextSizes.title3,
    );
  }
}
