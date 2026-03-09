import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:girlified/components/text/custom_text_widget.dart';

class AccountDetailMenuItemCard extends StatelessWidget {
  final String title;
  final String value;
  final String? routeTo;
  final String prefixIcon;
  final String? suffixIcon;
  final bool? isTextColumn;
  final double? prefixIconSize;
  final bool showSuffixIcon;
  const AccountDetailMenuItemCard({
    super.key,
    required this.title,
    required this.value,
    this.routeTo,
    required this.prefixIcon,
    this.suffixIcon,
    this.isTextColumn = true,
    this.showSuffixIcon = true,
    this.prefixIconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (routeTo == null) {
          return;
        }

        if (routeTo!.isNotEmpty) {
          Get.toNamed(routeTo!);
        }
      },
      overlayColor: WidgetStateProperty.all(
        Colors.transparent,
      ),
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: AppSizes.vertical_20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/$prefixIcon.png',
                  width: prefixIconSize ?? 20,
                  color: AppColors.grayColor.withOpacity(0.8),
                ),
                const SizedBox(width: AppSizes.horizontal_10),
                Visibility(
                  visible: !isTextColumn!,
                  child: CustomTextWidget(
                    size: 16,
                    text: title,
                    weight: FontWeight.w500,
                    textStyleName: AppTextSizes.bodyText1,
                  ),
                ),
                Visibility(
                  visible: isTextColumn!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(
                        text: title,
                        weight: FontWeight.w400,
                        color: AppColors.grayColor.withOpacity(0.8),
                      ),
                      SubtitleText(
                        text: value,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: showSuffixIcon,
              child: Image.asset(
                'assets/icons/$suffixIcon.png',
                width: 20,
                color: AppColors.grayColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
