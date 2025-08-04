import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';

class CustomBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Function? callBackFunction;
  const CustomBackButton({
    super.key,
    this.backgroundColor,
    this.callBackFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callBackFunction == null) {
          Get.back();
        } else {
          callBackFunction!();
        }
      },
      child: CircleAvatar(
        radius: 16,
        backgroundColor: backgroundColor ??
            AppColors.grayLightColor.withOpacity(
              0.3,
            ),
        child: Image.asset(
          'assets/icons/icon_arrow_left.png',
          width: 20,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
