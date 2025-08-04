import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/small_text.dart';

class HomeCycleOverviewContainer extends StatelessWidget {
  const HomeCycleOverviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.horizontal_20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.grayLightColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with calendar icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: AppColors.whiteColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: AppSizes.horizontal_8),
              TitleText(
                title: 'Cycle Tracking',
                size: 18,
                weight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ],
          ),

          const SizedBox(height: AppSizes.vertical_10),

          // Main cycle information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Day info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day 14',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                  const SizedBox(height: 4),
                  SmallText(
                    text: 'of 28-day cycle',
                    color: AppColors.contentTertiaryColor,
                  ),
                ],
              ),

              // Right side - Ovulation info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Ovulation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.orangeColor,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                  const SizedBox(height: 4),
                  SmallText(
                    text: 'Peak fertility',
                    color: AppColors.contentTertiaryColor,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSizes.vertical_10),

          // Progress bar
          _buildCycleProgressBar(),

          const SizedBox(height: AppSizes.vertical_10),

          // Cycle phase labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(
                text: 'Period',
                color: AppColors.contentTertiaryColor,
              ),
              SmallText(
                text: 'Ovulation',
                color: AppColors.contentTertiaryColor,
              ),
              SmallText(
                text: 'Next Period',
                color: AppColors.contentTertiaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCycleProgressBar() {
    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.grayLightColor,
      ),
      child: Stack(
        children: [
          // Background track
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.grayLightColor,
            ),
          ),

          // Active progress (Day 14 of 28 = 50%)
          FractionallySizedBox(
            widthFactor: 0.5, // 14/28 = 0.5
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.orangeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
