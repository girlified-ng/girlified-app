import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/navigation.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/data/repositories/common_repository.dart';

class CustomAuthBackButton extends StatefulWidget {
  final String? navigateTo;
  const CustomAuthBackButton({super.key, this.navigateTo});

  @override
  State<CustomAuthBackButton> createState() => _CustomAuthBackButtonState();
}

class _CustomAuthBackButtonState extends State<CustomAuthBackButton> {
  CommonRepository commonRepository = Get.find<CommonRepository>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (widget.navigateTo) {
          case AuthNavigationTypes.authSignIn:
            Get.toNamed(AppRoutes.loginRoute);

            break;
          case AuthNavigationTypes.authSignUp:
            Get.toNamed(AppRoutes.signUpRoute);
            break;
          default:
            Get.back();
        }
      },
      overlayColor: const WidgetStatePropertyAll(
        Colors.transparent,
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.grayLightColor.withOpacity(0.8),
        radius: 18,
        child: const Icon(
          FluentIcons.arrow_left_12_regular,
          size: 16,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
