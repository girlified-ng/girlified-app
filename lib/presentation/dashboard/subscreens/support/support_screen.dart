import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:girlified/components/cards/redirect_menu_item_card.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
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
                  title: 'Support',
                ),
                SizedBox(),
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
            const RedirectMenuItemCard(
              title: 'WhatsApp',
              prefixIcon: 'icon_whatsapp',
              suffixIcon: 'icon_redirect',
              routeTo: 'https://wa.me/+2348116947324',
            ),
            RedirectMenuItemCard(
              title: 'Call Us',
              prefixIcon: 'icon_telephone',
              suffixIcon: 'icon_redirect',
              routeTo: '+2348116947324',
            ),
          ],
        ),
      ),
    );
  }
}
