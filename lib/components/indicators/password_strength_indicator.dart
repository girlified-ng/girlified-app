import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final RxInt passwordStrength;
  final RxBool passwordHasNumber;
  final RxBool passwordHasUppercase;
  const PasswordStrengthIndicator({
    super.key,
    required this.passwordStrength,
    required this.passwordHasNumber,
    required this.passwordHasUppercase,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.grayLightColor.withOpacity(0.6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.subtract_12_regular,
                    size: 16,
                    color: passwordStrength.value > 7
                        ? AppColors.successPrimaryColor
                        : AppColors.grayColor.withOpacity(0.8),
                  ),
                  const SizedBox(width: AppSizes.horizontal_3),
                  SubtitleText(
                    weight: FontWeight.w400,
                    text: 'At least 8 characters',
                    color: passwordStrength.value > 7
                        ? AppColors.successPrimaryColor
                        : AppColors.grayColor.withOpacity(0.8),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.vertical_8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.subtract_12_regular,
                    size: 16,
                    color: passwordHasUppercase.isTrue
                        ? AppColors.successPrimaryColor
                        : AppColors.grayColor.withOpacity(0.8),
                  ),
                  const SizedBox(width: AppSizes.horizontal_3),
                  SubtitleText(
                    weight: FontWeight.w400,
                    text: 'At least 1 uppercase',
                    color: passwordHasUppercase.isTrue
                        ? AppColors.successPrimaryColor
                        : AppColors.grayColor.withOpacity(0.8),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.vertical_8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.subtract_12_regular,
                    size: 16,
                    color: passwordHasNumber.isTrue
                        ? AppColors.successPrimaryColor
                        : AppColors.grayColor.withOpacity(0.8),
                  ),
                  const SizedBox(width: AppSizes.horizontal_3),
                  SubtitleText(
                    weight: FontWeight.w400,
                    text: 'At least 1 number',
                    color: passwordHasNumber.isTrue
                        ? AppColors.successPrimaryColor
                        : AppColors.grayColor.withOpacity(0.8),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
