import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/appbar/default_appbar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/components/containers/home_intro_container.dart';
import 'package:girlified/components/containers/home_overview_container.dart';
import 'package:girlified/components/containers/home_insights_container.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';
import 'package:girlified/components/containers/home_cycle_overview_container.dart';
import 'package:girlified/components/containers/home_recent_activity_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> initializeHomeFeed() async {}

  @override
  void initState() {
    super.initState();

    initializeHomeFeed();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppbar(
          title: 'Girlified',
          showBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontal_10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeIntroContainer(),
            const SizedBox(height: AppSizes.vertical_20),
            SizedBox(
              width: AppSizes.screenWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      ServiceRegistry
                          .commonRepository.currentScreenIndex.value = 2;

                      Get.toNamed(AppRoutes.dashboardRoute);
                    },
                    child: Container(
                      height: 120,
                      width: AppSizes.screenWidth(context) * 0.45,
                      decoration: BoxDecoration(
                        color: AppColors.orangeColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FluentIcons.camera_16_regular,
                            color: AppColors.whiteColor,
                          ),
                          BodyText(
                            text: 'Take a photo',
                            color: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    width: AppSizes.screenWidth(context) * 0.45,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(
                        color: AppColors.grayLightColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FluentIcons.arrow_trending_12_regular,
                          color: AppColors.orangeColor,
                        ),
                        BodyText(
                          text: 'View results',
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.vertical_20),
            const HomeOverviewContainer(),
            const SizedBox(height: AppSizes.vertical_20),
            const HomeCycleOverviewContainer(),
            const SizedBox(height: AppSizes.vertical_20),
            const HomeRecentActivityContainer(),
            const SizedBox(height: AppSizes.vertical_20),
            const HomeInsightsContainer(),
            const SizedBox(height: AppSizes.vertical_50),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (int value) {
          ServiceRegistry.commonRepository.currentScreenIndex.value = value;
        },
        currentPage: ServiceRegistry.commonRepository.currentScreenIndex.value,
      ),
    );
  }
}
