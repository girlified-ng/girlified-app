import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/text/small_text.dart';

class HomeRecentActivityContainer extends StatelessWidget {
  const HomeRecentActivityContainer({super.key});

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
          // Header with trending icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: AppColors.whiteColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: AppSizes.horizontal_8),
              TitleText(
                title: 'Recent Activity',
                size: 18,
                weight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ],
          ),

          const SizedBox(height: AppSizes.vertical_20),

          // Activity items
          _buildActivityItem(
            icon: Icons.water_drop_outlined,
            iconColor: AppColors.orangeColor,
            backgroundColor: const Color(0xFFFFF7ED),
            title: 'Flow logged',
            timestamp: '2 hours ago',
          ),

          const SizedBox(height: AppSizes.vertical_16),

          _buildActivityItem(
            icon: Icons.monitor_heart_outlined,
            iconColor: AppColors.greenColor,
            backgroundColor: const Color(0xFFF0FDF4),
            title: 'Test completed',
            timestamp: 'Yesterday',
          ),

          const SizedBox(height: AppSizes.vertical_16),

          _buildActivityItem(
            icon: Icons.schedule,
            iconColor: AppColors.adBannerColor,
            backgroundColor: const Color(0xFFFFF7ED),
            title: 'Ovulation reminder',
            timestamp: '3 days ago',
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String timestamp,
  }) {
    return Row(
      children: [
        // Icon container
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),

        const SizedBox(width: AppSizes.horizontal_12),

        // Title and timestamp
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: title,
                weight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              const SizedBox(height: 2),
              SmallText(
                text: timestamp,
                color: AppColors.contentTertiaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
