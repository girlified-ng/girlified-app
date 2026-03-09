import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/middlewares/index.dart';
import 'package:girlified/components/text/subtitle_text.dart';

class RedirectMenuItemCard extends StatelessWidget {
  final String title;
  final String routeTo;
  final String prefixIcon;
  final String suffixIcon;
  final bool isIconEnabled;
  final Function? onTapHandler;
  const RedirectMenuItemCard({
    super.key,
    this.onTapHandler,
    required this.title,
    this.prefixIcon = '',
    required this.routeTo,
    required this.suffixIcon,
    this.isIconEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (title == 'Support') {
          Get.toNamed(AppRoutes.supportRoute);
        } else if (title == 'Call us') {
          try {
            Uri url = Uri(scheme: 'tel', path: routeTo);

            await canLaunchUrl(url);

            await launchUrl(url, mode: LaunchMode.externalApplication);
          } catch (error) {
            log('[LAUNCH-HELP-URL-ERROR] :: [URL] -> $routeTo [ERROR] -> ${error.toString()}');
          }
        } else if (routeTo.isEmail) {
          try {
            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: routeTo,
              query: encodeQueryParameters(<String, String>{
                'subject': 'Help',
                'body': 'Hello, ',
              }),
            );

            await canLaunchUrl(emailUri);
            await launchUrl(
              emailUri,
              mode: LaunchMode.externalApplication,
            );
          } catch (error) {
            log('[LAUNCH-HELP-URL-ERROR] :: [URL] -> $routeTo [ERROR] -> ${error.toString()}');
          }
        } else {
          try {
            Uri url = Uri.parse(routeTo);
            await canLaunchUrl(url);

            await launchUrl(url, mode: LaunchMode.externalApplication);
          } catch (error) {
            log('[LAUNCH-HELP-URL-ERROR] :: [URL] -> $routeTo [ERROR] -> ${error.toString()}');
          }
        }
      },
      overlayColor: const WidgetStatePropertyAll(
        Colors.transparent,
      ),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.vertical_10,
        ),
        margin: const EdgeInsets.only(bottom: AppSizes.vertical_10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Visibility(
                  visible: isIconEnabled,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/$prefixIcon.png',
                        width: 20,
                        color: AppColors.grayColor.withOpacity(0.8),
                      ),
                      const SizedBox(width: AppSizes.horizontal_10),
                    ],
                  ),
                ),
                SubtitleText(
                  text: title,
                ),
              ],
            ),
            Image.asset(
              'assets/icons/$suffixIcon.png',
              width: 20,
              color: AppColors.grayColor.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
