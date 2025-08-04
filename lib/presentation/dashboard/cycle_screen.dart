import 'package:flutter/material.dart';
import 'package:girlified/components/appbar/default_appbar.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';

class CycleScreen extends StatefulWidget {
  const CycleScreen({super.key});

  @override
  State<CycleScreen> createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
  // Calendar data
  final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final Map<int, Color> dayColors = {
    4: AppColors.orangeColor, // Current day
    12: AppColors.orangeColor.withOpacity(0.2), // Flow days
    13: AppColors.orangeColor.withOpacity(0.2),
    14: AppColors.orangeColor, // Ovulation day
    15: AppColors.orangeColor.withOpacity(0.2),
    16: AppColors.orangeColor.withOpacity(0.2),
    25: AppColors.orangeColor.withOpacity(0.1),
    26: AppColors.orangeColor.withOpacity(0.1),
    27: AppColors.orangeColor.withOpacity(0.1),
    28: AppColors.orangeColor.withOpacity(0.1),
  };

  Widget _buildStatItem({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: valueColor,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          BodyText(
            text: label,
            color: AppColors.contentTertiaryColor,
            alignment: TextAlign.center,
            size: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSizes.horizontal_8),
        BodyText(
          text: label,
          color: AppColors.blackColor,
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    // Calculate available width for each day cell
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth -
        (AppSizes.horizontal_20 *
            4); // Account for parent padding and card padding
    final cellWidth =
        (availableWidth / 7).floor().toDouble(); // Divide by 7 days

    return Column(
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekDays
              .map(
                (day) => SizedBox(
                  width: cellWidth,
                  child: BodyText(
                    text: day,
                    color: AppColors.contentTertiaryColor,
                    alignment: TextAlign.center,
                    weight: FontWeight.w500,
                    size: 13,
                  ),
                ),
              )
              .toList(),
        ),

        const SizedBox(height: AppSizes.vertical_16),

        // Calendar days
        ...List.generate(5, (weekIndex) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.vertical_16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (dayIndex) {
                final day = weekIndex * 7 + dayIndex + 1;
                if (day > 31)
                  return SizedBox(
                      width: cellWidth); // Empty space for days beyond month

                final isToday = day == 14; // Current day
                final hasIndicator = dayColors.containsKey(day);

                return SizedBox(
                  width: cellWidth,
                  height: cellWidth,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Day circle/indicator
                      if (isToday)
                        Container(
                          width: cellWidth *
                              0.8, // Make circle slightly smaller than cell
                          height: cellWidth * 0.8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.orangeColor,
                          ),
                        ),

                      // Day number
                      Text(
                        day.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isToday ? FontWeight.w600 : FontWeight.w400,
                          color: isToday
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),

                      // Bottom dot indicator
                      if (hasIndicator && !isToday)
                        Positioned(
                          bottom: cellWidth * 0.15,
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: dayColors[day],
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppbar(
          title: 'Cycle',
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
            // Current Cycle Card
            Container(
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
                  // Header row with title and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            title: 'Current Cycle',
                            size: 24,
                            weight: FontWeight.w700,
                          ),
                          const SizedBox(height: 4),
                          BodyText(
                            text: 'Day 14 of 28',
                            color: AppColors.contentTertiaryColor,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.horizontal_12,
                          vertical: AppSizes.vertical_6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.orangeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: BodyText(
                          text: 'Ovulating',
                          color: AppColors.whiteColor,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_30),

                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatItem(
                        value: '14',
                        label: 'Days until next\nperiod',
                        valueColor: AppColors.orangeColor,
                      ),
                      _buildStatItem(
                        value: '95%',
                        label: 'Prediction\naccuracy',
                        valueColor: AppColors.greenColor,
                      ),
                      _buildStatItem(
                        value: '28',
                        label: 'Average cycle\nlength',
                        valueColor: AppColors.blackColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_30),

            // Calendar section
            Container(
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
                children: [
                  // Month navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_left),
                        color: AppColors.contentTertiaryColor,
                      ),
                      TitleText(
                        title: 'August 2025',
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_right),
                        color: AppColors.contentTertiaryColor,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_20),

                  // Calendar grid
                  _buildCalendarGrid(),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_20),

            // Today's Details Section
            Container(
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
                          color: AppColors.orangeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          color: AppColors.orangeColor,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: AppSizes.horizontal_8),
                      TitleText(
                        title: "Today's Details",
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Fertility Status Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSizes.horizontal_16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.orangeColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.orangeColor,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: AppSizes.horizontal_12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyText(
                                text: 'Fertility Status',
                                weight: FontWeight.w600,
                                size: 16,
                              ),
                              const SizedBox(height: 4),
                              BodyText(
                                text: 'Peak fertility - ovulation day',
                                color: AppColors.contentTertiaryColor,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.horizontal_12,
                            vertical: AppSizes.vertical_4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orangeColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: BodyText(
                            text: 'High',
                            color: AppColors.whiteColor,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSizes.vertical_12),

                  // Symptoms Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSizes.horizontal_16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color:
                                AppColors.contentTertiaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.show_chart,
                            color: AppColors.contentTertiaryColor,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: AppSizes.horizontal_12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyText(
                                text: 'Symptoms',
                                weight: FontWeight.w600,
                                size: 16,
                              ),
                              const SizedBox(height: 4),
                              BodyText(
                                text: 'Increased energy, mood boost',
                                color: AppColors.contentTertiaryColor,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: AppColors.contentTertiaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_20),

            // Quick Log Section
            Container(
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
                  TitleText(
                    title: 'Quick Log',
                    size: 18,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(height: AppSizes.vertical_16),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding:
                                const EdgeInsets.all(AppSizes.horizontal_20),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.grayLightColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.water_drop_outlined,
                                  color: AppColors.orangeColor,
                                  size: 24,
                                ),
                                const SizedBox(height: AppSizes.vertical_8),
                                BodyText(
                                  text: 'Log Flow',
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.horizontal_12),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding:
                                const EdgeInsets.all(AppSizes.horizontal_20),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.grayLightColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: AppColors.orangeColor,
                                  size: 24,
                                ),
                                const SizedBox(height: AppSizes.vertical_8),
                                BodyText(
                                  text: 'Symptoms',
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_20),

            // Legend Section
            Container(
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
                  TitleText(
                    title: 'Legend',
                    size: 18,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(height: AppSizes.vertical_16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildLegendItem(
                              color: AppColors.redColor,
                              label: 'Heavy flow',
                            ),
                            const SizedBox(height: AppSizes.vertical_12),
                            _buildLegendItem(
                              color: AppColors.orangeColor,
                              label: 'Ovulation',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _buildLegendItem(
                              color: AppColors.orangeColor.withOpacity(0.5),
                              label: 'Medium flow',
                            ),
                            const SizedBox(height: AppSizes.vertical_12),
                            _buildLegendItem(
                              color: AppColors.orangeColor.withOpacity(0.2),
                              label: 'Fertile window',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_30),
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
