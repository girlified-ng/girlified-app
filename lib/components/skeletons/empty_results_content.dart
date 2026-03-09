import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';

class EmptyResultsContent extends StatelessWidget {
  final double? height;
  final String displayType;
  const EmptyResultsContent(
      {super.key, this.height, required this.displayType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: height ?? AppSizes.screenHeight(context) * 0.5,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontal_30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: displayType == 'COMPLETED_ORDERS' ? 65 : 50,
            height: displayType == 'COMPLETED_ORDERS' ? 65 : 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/icons/icon_${displayType == 'NOTIFICATIONS' ? 'bell' : displayType == 'ONGOING_ORDERS' ? 'package' : displayType == 'COMPLETED_ORDERS' ? 'package_open' : 'search_circled'}.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.vertical_10),
          Visibility(
            visible: true,
            child: TitleText(
              size: 20,
              title: displayType == 'NOTIFICATIONS'
                  ? 'No New Notification'
                  : displayType == 'ONGOING_ORDERS'
                      ? 'No Ongoing Orders'
                      : displayType == 'COMPLETED_ORDERS'
                          ? 'No Completed Orders'
                          : 'No Results',
            ),
          ),
          const SizedBox(height: AppSizes.vertical_5),
          SubtitleText(
            alignment: TextAlign.center,
            text: displayType == 'NOTIFICATIONS'
                ? 'You will see new notification here once you create one'
                : displayType == 'ONGOING_ORDERS'
                    ? 'No Ongoing Orders At The Moment'
                    : displayType == 'COMPLETED_ORDERS'
                        ? 'No Completed Orders At The Moment'
                        : 'No Results',
          ),
        ],
      ),
    );
  }
}
