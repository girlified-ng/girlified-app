import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:girlified/data/services/auth_middlewares.dart';

class LogoutConfirmationModal extends StatelessWidget {
  const LogoutConfirmationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shadowColor: AppColors.whiteColor,
      backgroundColor: AppColors.backgroundColor,
      content: Container(
        height: 120,
        width: double.maxFinite,
        padding: const EdgeInsets.only(
          top: AppSizes.horizontal_20,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontal_20,
              ),
              child: Column(
                children: [
                  SubtitleText(
                    weight: FontWeight.w600,
                    alignment: TextAlign.center,
                    text: 'Are you sure to want to logout?',
                  ),
                ],
              ),
            ),
            Container(
              height: 44,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.grayLightColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: double.maxFinite,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: AppColors.grayLightColor,
                            ),
                          ),
                        ),
                        child: Center(
                          child: SubtitleText(
                            text: 'Cancel',
                            color: AppColors.redColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        userLogoutHandler(hasContext: true, context: context);
                      },
                      child: SizedBox(
                        height: double.maxFinite,
                        child: Center(
                          child: SubtitleText(
                            text: 'Yes',
                            color: AppColors.greenColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
