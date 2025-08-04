import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingButton extends StatelessWidget {
  final double? width;
  final double height;
  final Color? fontColor;
  final Color? borderColor;
  final double animationSize;
  final double? borderRadius;
  final Color? backgroundColor;

  const CustomLoadingButton({
    super.key,
    this.width,
    this.fontColor,
    this.borderColor,
    this.borderRadius,
    required this.height,
    this.backgroundColor,
    this.animationSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        color: backgroundColor ?? AppColors.buttonPrimaryColor,
        border: Border.all(
          color: borderColor ?? AppColors.buttonPrimaryColor,
        ),
      ),
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          size: animationSize,
          color: fontColor ?? AppColors.whiteColor,
        ),
      ),
    );
  }
}
