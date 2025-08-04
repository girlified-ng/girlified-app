import 'package:flutter/material.dart';
import 'package:girlified/components/text/custom_text_widget.dart';
import 'package:girlified/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final double borderRadius;
  final String text;
  final double width;
  final double height;
  final Function onTapHandler;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final Color? borderColor;
  final TextAlign? textAlignment;

  const CustomButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onTapHandler,
    required this.fontSize,
    required this.fontColor,
    required this.fontWeight,
    required this.borderRadius,
    required this.backgroundColor,
    this.borderColor,
    this.textAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: fontColor,
          backgroundColor: backgroundColor,
          overlayColor: AppColors.grayLightColor,
          // surfaceTintColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
        ),
        onPressed: () => onTapHandler(),
        child: CustomTextWidget(
          text: text,
          color: fontColor,
          size: fontSize,
          weight: fontWeight,
          alignment: textAlignment ?? TextAlign.left,
        ),
      ),
    );
  }
}
