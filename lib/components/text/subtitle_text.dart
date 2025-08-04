import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/custom_text_widget.dart';

class SubtitleText extends CustomTextWidget {
  SubtitleText({
    super.key,
    Color? color,
    int? maxLines,
    double? size,
    double? lineHeight,
    FontWeight? weight,
    required String text,
    FontStyle? fontStyle,
    TextAlign? alignment,
    Color? decorationColor,
    TextDecoration? decoration,
  }) : super(
          text: text,
          size: size ?? 16,
          lineHeight: lineHeight,
          maxLines: maxLines ?? 6,
          weight: weight ?? FontWeight.w400,
          fontStyle: fontStyle,
          textStyleName: AppTextSizes.bodyText1,
          alignment: alignment ?? TextAlign.left,
          color: color ?? AppColors.blackColor,
          decoration: decoration ?? TextDecoration.none,
          decorationColor: decorationColor ?? Colors.transparent,
        );
}
