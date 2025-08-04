import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/body_text.dart';

class HomeInsightsContainer extends StatelessWidget {
  const HomeInsightsContainer({super.key});

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
          // Header title
          TitleText(
            title: "Today's Insights",
            size: 20,
            weight: FontWeight.w700,
            color: AppColors.blackColor,
          ),

          const SizedBox(height: AppSizes.vertical_16),

          // Insight card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.horizontal_16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0F5), // Light pink background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exclamation icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orangeColor.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.priority_high,
                    color: AppColors.orangeColor,
                    size: 20,
                  ),
                ),

                const SizedBox(width: AppSizes.horizontal_12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(
                        weight: FontWeight.w600,
                        text: 'Peak Fertility Window',
                        color: AppColors.blackColor,
                        size: 16,
                      ),
                      const SizedBox(height: AppSizes.vertical_8),
                      BodyText(
                        text:
                            "You're in your most fertile period. Consider tracking symptoms and scheduling intimate time if trying to conceive.",
                        weight: FontWeight.w400,
                        lineHeight: 1.5,
                        color: AppColors.contentTertiaryColor,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
