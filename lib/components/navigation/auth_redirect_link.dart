import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';

class AuthRedirectLink extends StatelessWidget {
  final String routeType;
  final double fontSize;
  const AuthRedirectLink({
    super.key,
    this.routeType = 'SIGNUP',
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ROUTE TO SIGNUP SCREEN
        if (routeType == 'SIGNUP') {
          Get.toNamed(AppRoutes.signUpRoute);
        } else {
          Get.toNamed(AppRoutes.loginRoute);
        }
      },
      overlayColor: const WidgetStatePropertyAll(
        Colors.transparent,
      ),
      child: routeType == 'SIGNUP'
          ? RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: fontSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          color: AppColors.textTertiaryColor,
                        ),
                  ),
                  TextSpan(
                    text: "Sign up",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: fontSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: AppColors.textWarningColor,
                        ),
                  ),
                ],
              ),
            )
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: fontSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          color: AppColors.textTertiaryColor,
                        ),
                  ),
                  TextSpan(
                    text: "Sign in",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: fontSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: AppColors.textWarningColor,
                        ),
                  ),
                ],
              ),
            ),
    );
  }
}
