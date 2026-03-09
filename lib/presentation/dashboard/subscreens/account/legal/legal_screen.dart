import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:girlified/components/cards/redirect_menu_item_card.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        version = packageInfo.version;
      });
      log('Package version: ${packageInfo.packageName}');
    } catch (e) {
      log('Error getting package info: $e');
      setState(() {
        version = '2.5.1'; // Fallback to pubspec version
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SafeArea(
          // padding: MediaQuery.of(context).padding,
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontal_15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomBackButton(),
                TitleText(
                  letterSpacing: 0,
                  fontFamily: 'Roboto',
                  title: 'Legal',
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontal_15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.vertical_5),
            TitleText(
              size: 20,
              title: 'Version $version',
              weight: FontWeight.w700,
            ),
            const SizedBox(height: AppSizes.vertical_20),
            RedirectMenuItemCard(
              title: 'Terms and Conditions',
              isIconEnabled: false,
              suffixIcon: 'icon_redirect',
              routeTo: 'https://girlified.com.ng/terms-of-service',
            ),
            RedirectMenuItemCard(
              title: 'Privacy Policy',
              isIconEnabled: false,
              suffixIcon: 'icon_redirect',
              routeTo: 'https://girlified.com.ng/privacy-policy',
            ),
            // RedirectMenuItemCard(
            //   title: 'Rate the app'.tr,
            //   isIconEnabled: false,
            //   suffixIcon: 'icon_redirect',
            //   routeTo: Platform.isIOS
            //       ? dotenv.env['APP_LINK_IOS']!
            //       : dotenv.env['APP_LINK_ANDROID']!,
            // ),
          ],
        ),
      ),
    );
  }
}
