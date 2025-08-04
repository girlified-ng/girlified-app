import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/large_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';

class HomeIntroContainer extends StatelessWidget {
  const HomeIntroContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.horizontal_20),
      decoration: BoxDecoration(
        color: Colors.orange.shade100, // Light pink background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main greeting
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LargeText(
                    text: 'Good morning, Sarah',
                    weight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(height: AppSizes.vertical_8),
                  SubtitleText(
                    text: 'Day 14 of your cycle',
                    color: AppColors.contentTertiaryColor,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
              // Notification bell icon
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.blackColor,
                  size: 24,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.vertical_20),

          // Ovulation notification badge
          Container(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.vertical_8,
              horizontal: AppSizes.horizontal_16,
            ),
            decoration: BoxDecoration(
              color: AppColors.blueLightColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: SubtitleText(
              text: 'Ovulation window detected',
              color: Colors.white,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
