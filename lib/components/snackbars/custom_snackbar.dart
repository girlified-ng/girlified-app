import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

void customNotificationSnackbar({
  int duration = 6500,
  required String title,
  required String message,
  Function()? onTap,
  Color colorText = AppColors.whiteColor,
  Color backgroundColor = AppColors.blackColor,
}) {
  Get.snackbar(
    title,
    message,
    onTap: (GetSnackBar snackBar) {
      if (onTap != null) {
        onTap();
      }
    },
    colorText: colorText,
    shouldIconPulse: false,
    backgroundColor: backgroundColor,
    icon: const Icon(
      FluentIcons.info_12_filled,
      size: 18,
      color: AppColors.buttonPrimaryColor,
    ),
    duration: Duration(milliseconds: duration),
  );
}

void customSuccessMessageSnackbar({
  int duration = 3500,
  required String title,
  required String message,
  Color colorText = AppColors.whiteColor,
  Color backgroundColor = AppColors.blackColor,
}) {
  Get.snackbar(
    title,
    message,
    colorText: colorText,
    shouldIconPulse: false,
    backgroundColor: backgroundColor,
    icon: const Icon(
      FluentIcons.checkmark_circle_12_filled,
      size: 18,
      color: AppColors.successPrimaryColor,
    ),
    duration: Duration(milliseconds: duration),
  );
}

void customErrorMessageSnackbar({
  int duration = 3500,
  required String title,
  required String message,
  Color colorText = AppColors.whiteColor,
  Color backgroundColor = AppColors.blackColor,
}) {
  Get.snackbar(
    title,
    message,
    colorText: colorText,
    shouldIconPulse: false,
    backgroundColor: backgroundColor,
    icon: const Icon(
      FluentIcons.info_12_filled,
      size: 18,
      color: AppColors.dangerColor,
    ),
    duration: Duration(milliseconds: duration),
  );
}
