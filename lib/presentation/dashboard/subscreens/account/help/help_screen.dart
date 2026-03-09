import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:girlified/components/cards/redirect_menu_item_card.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/sizes.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ServiceRegistry.commonRepository.currentScreenIndex.value = 3;

        Get.until((route) => Get.currentRoute == AppRoutes.accountRoute);

        return false;
      },
      child: Scaffold(
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
                  CustomBackButton(
                    callBackFunction: () {
                      // ServiceRegistry
                      //     .commonRepository.currentScreenIndex.value = 3;

                      Get.until((route) =>
                          Get.currentRoute == AppRoutes.accountRoute);
                    },
                  ),
                  TitleText(
                    letterSpacing: 0,
                    fontFamily: 'Roboto',
                    title: 'Help',
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
              RedirectMenuItemCard(
                routeTo: '',
                title: 'Support',
                prefixIcon: 'icon_support',
                suffixIcon: 'icon_chevron_right',
              ),
              RedirectMenuItemCard(
                title: 'Email',
                prefixIcon: 'icon_email',
                suffixIcon: 'icon_redirect',
                routeTo: 'support@venille.com.ng',
              ),
              // RedirectMenuItemCard(
              //   title: 'X (Twitter)',
              //   prefixIcon: 'icon_twitter',
              //   suffixIcon: 'icon_redirect',
              //   routeTo: 'https://twitter.com/venille',
              // ),
              // const RedirectMenuItemCard(
              //   title: 'Instagram',
              //   prefixIcon: 'icon_instagram',
              //   suffixIcon: 'icon_redirect',
              //   routeTo: 'https://www.instagram.com/venille_',
              // ),
              // const RedirectMenuItemCard(
              //   title: 'Linkedin',
              //   suffixIcon: 'icon_redirect',
              //   prefixIcon: 'icon_linkedin',
              //   routeTo: 'https://www.linkedin.com/company/venille-ng',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
