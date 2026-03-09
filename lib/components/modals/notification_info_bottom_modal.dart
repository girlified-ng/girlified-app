import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/middlewares/index.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:girlified/components/buttons/custom_x_button.dart';
import 'package:account_sdk/account_sdk.dart';

class NotificationInfoBottomModal extends StatefulWidget {
  final NotificationInfo notification;

  const NotificationInfoBottomModal({
    super.key,
    required this.notification,
  });

  @override
  State<NotificationInfoBottomModal> createState() =>
      _NotificationInfoBottomModalState();
}

class _NotificationInfoBottomModalState
    extends State<NotificationInfoBottomModal> {
  void readNotification() {
    if (widget.notification.isRead == false) {
      ServiceRegistry.accountService.readNotificationsService(
        notificationId: int.parse(widget.notification.id),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    readNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.vertical_5,
        horizontal: AppSizes.horizontal_15,
      ),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  size: 20,
                  title: '',
                ),
                CustomXButton(),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.vertical_5),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    size: 16,
                    title: widget.notification.title,
                  ),
                  const SizedBox(height: AppSizes.vertical_2),
                  SubtitleText(
                    maxLines: 20000,
                    text: widget.notification.message,
                    color: AppColors.textTertiaryColor,
                  ),
                  const SizedBox(height: AppSizes.vertical_10),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.vertical_10),
        ],
      ),
    );
  }
}
