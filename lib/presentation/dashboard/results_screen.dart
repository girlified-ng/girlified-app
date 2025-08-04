import 'package:flutter/material.dart';
import 'package:girlified/components/appbar/default_appbar.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';

class TrendLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.contentTertiaryColor.withOpacity(0.1)
      ..strokeWidth = 1;

    // Draw horizontal grid lines
    for (var i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Draw y-axis labels
    const textStyle = TextStyle(
      color: AppColors.contentTertiaryColor,
      fontSize: 12,
    );
    final yLabels = ['8', '6.5', '5.5', '4.2'];
    for (var i = 0; i < yLabels.length; i++) {
      final textSpan = TextSpan(
        text: yLabels[i],
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(-25, (size.height * i / 3) - textPainter.height / 2),
      );
    }

    // Draw x-axis labels
    final xLabels = ['Jun \'23', 'Oct\'23', 'Jan \'24'];
    for (var i = 0; i < xLabels.length; i++) {
      final textSpan = TextSpan(
        text: xLabels[i],
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (size.width * i / 2) - textPainter.width / 2,
          size.height + 10,
        ),
      );
    }

    // Draw trend line
    final linePaint = Paint()
      ..color = AppColors.orangeColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final points = [
      Offset(0, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.35),
      Offset(size.width * 0.75, size.height * 0.4),
    ];

    // Draw orange part
    final orangePath = Path()
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[1].dx, points[1].dy);
    canvas.drawPath(orangePath, linePaint);

    // Draw green part
    final greenPaint = Paint()
      ..color = AppColors.greenColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final greenPath = Path()
      ..moveTo(points[1].dx, points[1].dy)
      ..lineTo(points[2].dx, points[2].dy);
    canvas.drawPath(greenPath, greenPaint);

    // Draw points
    final pointPaint = Paint()
      ..color = AppColors.whiteColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = AppColors.orangeColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 2; i++) {
      canvas.drawCircle(points[i], 6, borderPaint);
      canvas.drawCircle(points[i], 4, pointPaint);
    }

    // Last point in green
    final greenBorderPaint = Paint()
      ..color = AppColors.greenColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(points[2], 6, greenBorderPaint);
    canvas.drawCircle(points[2], 4, pointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
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
          color: AppColors.contentTertiaryColor,
          size: 12,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppbar(
          title: 'Results',
          showBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontal_20,
          vertical: AppSizes.vertical_20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Result Card
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  TitleText(
                    title: 'Average blood sugar',
                    size: 24,
                    weight: FontWeight.w700,
                  ),

                  const SizedBox(height: AppSizes.vertical_12),

                  // Collection Date
                  BodyText(
                    text: 'Collection Date: 1.15.2024',
                    color: AppColors.contentTertiaryColor,
                    size: 16,
                  ),

                  const SizedBox(height: AppSizes.vertical_30),

                  // Result Value
                  Text(
                    '5.6%',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: AppColors.greenColor,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: AppSizes.vertical_8),

                  // Status
                  Text(
                    'Normal range',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greenColor,
                    ),
                  ),

                  const SizedBox(height: AppSizes.vertical_20),

                  // Range Indicator
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_20),

                  // Result Description
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSizes.horizontal_16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BodyText(
                      text:
                          'Your result is within the normal range. It is the typical, healthy level for people without diabetes.',
                      color: AppColors.contentTertiaryColor,
                      lineHeight: 1.5,
                    ),
                  ),

                  const SizedBox(height: AppSizes.vertical_20),

                  // Biomarker Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyText(
                            text: 'Biomarker tested:',
                            color: AppColors.contentTertiaryColor,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BodyText(
                            text: 'Hemoglobin A1c',
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_30),

            // Trends Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  title: 'Trends over time',
                  size: 24,
                  weight: FontWeight.w700,
                ),

                const SizedBox(height: AppSizes.vertical_16),

                // Time Range Toggle
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.horizontal_16,
                        vertical: AppSizes.vertical_8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: BodyText(
                        text: '6 months',
                        weight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: AppSizes.horizontal_12),
                    BodyText(
                      text: '12 months',
                      color: AppColors.contentTertiaryColor,
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.vertical_30),

                // Graph Container
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.all(AppSizes.horizontal_20),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CustomPaint(
                    painter: TrendLinePainter(),
                    size: const Size(double.infinity, 200),
                  ),
                ),

                const SizedBox(height: AppSizes.vertical_16),

                // Legend
                Row(
                  children: [
                    _buildLegendItem(
                      color: AppColors.greenColor,
                      label: 'Normal range',
                    ),
                    const SizedBox(width: AppSizes.horizontal_20),
                    _buildLegendItem(
                      color: AppColors.orangeColor,
                      label: 'Elevated range',
                    ),
                    const SizedBox(width: AppSizes.horizontal_20),
                    _buildLegendItem(
                      color: AppColors.redColor,
                      label: 'Diabetic range',
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: AppSizes.vertical_30),

            // Download Report Button
            InkWell(
              onTap: () {
                // TODO: Implement report download
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.horizontal_16),
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.download,
                      color: AppColors.whiteColor,
                      size: 24,
                    ),
                    const SizedBox(width: AppSizes.horizontal_8),
                    BodyText(
                      text: 'Download Full Report',
                      color: AppColors.whiteColor,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSizes.vertical_16),

            // Schedule Follow-up Button
            InkWell(
              onTap: () {
                // TODO: Implement test scheduling
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.horizontal_16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.grayLightColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: AppColors.blackColor,
                      size: 24,
                    ),
                    const SizedBox(width: AppSizes.horizontal_8),
                    BodyText(
                      text: 'Schedule Follow-up Test',
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSizes.vertical_20),

            // What this means section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F7FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.blueColor,
                        size: 24,
                      ),
                      const SizedBox(width: AppSizes.horizontal_8),
                      BodyText(
                        text: 'What this means',
                        color: AppColors.blueColor,
                        weight: FontWeight.w600,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.vertical_12),
                  BodyText(
                    text:
                        'This biomarker helps assess your risk for diabetes and metabolic health. Regular monitoring can help detect changes early.',
                    color: AppColors.blueColor,
                    lineHeight: 1.5,
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
