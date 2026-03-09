import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:girlified/core/constants/colors.dart';

class CustomXButton extends StatelessWidget {
  final Function? callBackHandler;
  final bool? hasBackground;
  final Color? backgroundColor;
  const CustomXButton({
    super.key,
    this.callBackHandler,
    this.backgroundColor,
    this.hasBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (callBackHandler == null) {
          Navigator.pop(context);
        } else {
          callBackHandler!();
        }
      },
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: hasBackground == true
          ? CircleAvatar(
              radius: 16,
              backgroundColor: backgroundColor ??
                  AppColors.grayLightColor.withOpacity(
                    0.5,
                  ),
              child: const Icon(
                LucideIcons.x,
                size: 16,
                color: AppColors.blackColor,
              ),
            )
          : const Icon(
              LucideIcons.x,
              size: 16,
              color: AppColors.blackColor,
            ),
    );
  }
}
