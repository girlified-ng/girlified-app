import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/body_text.dart';

class GroupedHeaderButtons extends StatelessWidget {
  final String currentItem;
  final List<String> buttonTypes;
  final Function(String value) onChangeHandler;
  const GroupedHeaderButtons({
    super.key,
    required this.currentItem,
    required this.buttonTypes,
    required this.onChangeHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
      padding: const EdgeInsets.all(
        AppSizes.vertical_4,
      ),
      decoration: BoxDecoration(
        color: AppColors.grayLightColor,
        border: Border.all(
          color: AppColors.grayLightColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: List.generate(
          buttonTypes.length,
          (index) {
            return Expanded(
              child: InkWell(
                onTap: () {
                  log('[UPDATE-GROUPED-BUTTON-HANDLER]');

                  onChangeHandler(buttonTypes[index]);
                },
                overlayColor: WidgetStateProperty.all(
                  Colors.transparent,
                ),
                child: Container(
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: currentItem == buttonTypes[index]
                        ? AppColors.whiteColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: BodyText(
                      weight: currentItem == buttonTypes[index]
                          ? FontWeight.w500
                          : FontWeight.w400,
                      text: buttonTypes[index],
                      color: currentItem == buttonTypes[index]
                          ? AppColors.blackColor
                          : AppColors.grayColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
