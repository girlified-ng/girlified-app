import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  final double size;
  final Color color;
  final String type;
  const LoadingAnimation({
    super.key,
    this.size = 28,
    this.color = AppColors.buttonPrimaryColor,
    this.type = "",
  });

  @override
  Widget build(BuildContext context) {
    return type == "newtonCradle"
        ? LoadingAnimationWidget.newtonCradle(
            size: size,
            color: color,
          )
        : type == "progressiveDots"
            ? LoadingAnimationWidget.progressiveDots(
                size: size,
                color: color,
              )
            : type == "beat"
                ? LoadingAnimationWidget.beat(
                    size: size,
                    color: color,
                  )
                : LoadingAnimationWidget.hexagonDots(
                    size: size,
                    color: color,
                  );
  }
}
