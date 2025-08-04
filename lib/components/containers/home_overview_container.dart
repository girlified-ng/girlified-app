import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/small_text.dart';

class HomeOverviewContainer extends StatelessWidget {
  const HomeOverviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.all(AppSizes.horizontal_16),
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
          // Header with heart icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.redColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: AppColors.whiteColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: AppSizes.horizontal_8),
              TitleText(
                title: 'Health Overview',
                size: 18,
                weight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ],
          ),

          const SizedBox(height: AppSizes.vertical_16),

          // Reproductive Health
          _buildHealthItem(
            indicatorColor: AppColors.greenColor,
            backgroundColor: const Color(0xFFF0FDF4),
            title: 'Reproductive Health',
            subtitle: 'Normal range',
            onTap: () {},
          ),

          const SizedBox(height: AppSizes.vertical_8),

          // Hormone Levels
          _buildHealthItem(
            indicatorColor: AppColors.adBannerColor,
            backgroundColor: const Color(0xFFFFF7ED),
            title: 'Hormone Levels',
            subtitle: 'Elevated (ovulation)',
            onTap: () {},
          ),

          const SizedBox(height: AppSizes.vertical_8),

          // Cancer Screening
          _buildHealthItem(
            indicatorColor: AppColors.grayColor,
            backgroundColor: AppColors.grayLightColor,
            title: 'Cancer Screening',
            subtitle: 'No test this cycle',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHealthItem({
    required Color indicatorColor,
    required Color backgroundColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.horizontal_16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Colored dot indicator
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: indicatorColor,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: AppSizes.horizontal_12),

            // Title and subtitle
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
                    text: subtitle,
                    color: AppColors.contentTertiaryColor,
                  ),
                ],
              ),
            ),

            // Chevron arrow
            const Icon(
              Icons.chevron_right,
              color: AppColors.contentTertiaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
