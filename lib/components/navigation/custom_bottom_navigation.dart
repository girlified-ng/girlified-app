// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentPage;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.onTap,
    required this.currentPage,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) {
            TextStyle textStyle = const TextStyle(
              fontSize: 11,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: AppColors.textTertiaryInverseColor,
            );

            if (states.contains(MaterialState.selected)) {
              textStyle = textStyle.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.electricLilac,
              );
            }

            return textStyle;
          },
        ),
      ),
      child: NavigationBar(
        height: 60,
        onDestinationSelected: widget.onTap,
        indicatorColor: AppColors.electricLilac.withOpacity(0.2),
        // backgroundColor: AppColors.darkThemeAppBarBackgroundColor,
        animationDuration: const Duration(seconds: 0),
        selectedIndex:
            ServiceRegistry.commonRepository.currentScreenIndex.value,
        surfaceTintColor: AppColors.whiteColor,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: const Icon(
              FluentIcons.shield_checkmark_16_regular,
              size: 20,
              color: AppColors.textTertiaryInverseColor,
            ),
            selectedIcon: const Icon(
              FluentIcons.shopping_bag_16_regular,
              size: 20,
              color: AppColors.electricLilac,
            ),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: const Icon(
              FluentIcons.shield_checkmark_16_regular,
              size: 20,
              color: AppColors.textTertiaryInverseColor,
            ),
            selectedIcon: const Icon(
              FluentIcons.shield_checkmark_16_filled,
              size: 20,
              color: AppColors.electricLilac,
            ),
            label: 'Safe AI',
          ),
          NavigationDestination(
            icon: const Icon(
              FluentIcons.history_16_regular,
              size: 20,
              color: AppColors.textTertiaryInverseColor,
            ),
            selectedIcon: const Icon(
              FluentIcons.history_16_filled,
              size: 20,
              color: AppColors.electricLilac,
            ),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: const Icon(
              FluentIcons.person_16_regular,
              size: 20,
              color: AppColors.textTertiaryInverseColor,
            ),
            selectedIcon: const Icon(
              FluentIcons.person_16_filled,
              size: 20,
              color: AppColors.electricLilac,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
