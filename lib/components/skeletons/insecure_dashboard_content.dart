import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/buttons/custom_button.dart';

class InsecureDashboardContent extends StatelessWidget {
  const InsecureDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontal_20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/icon_unauthorised_user.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(height: AppSizes.vertical_30),
          CustomButton(
            text: 'Login',
            width: 120,
            height: 46,
            fontSize: 16,
            borderRadius: 16,
            onTapHandler: () => Get.toNamed(AppRoutes.loginRoute),
            fontWeight: FontWeight.w600,
            fontColor: AppColors.whiteColor,
            backgroundColor: AppColors.blackColor,
          )
        ],
      ),
    );
  }
}
