import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';

class DefaultAppbar extends StatefulWidget {
  final String title;
  final IconData? icon;
  final bool showBackButton;
  final VoidCallback? onTap;
  const DefaultAppbar({
    super.key,
    this.title = '',
    this.icon,
    this.onTap,
    this.showBackButton = false,
  });

  @override
  State<DefaultAppbar> createState() => _DefaultAppbarState();
}

class _DefaultAppbarState extends State<DefaultAppbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontal_15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: AppSizes.horizontal_35),
            TitleText(
              size: 16,
              title: widget.title,
            ),
            const SizedBox(width: AppSizes.horizontal_35),
          ],
        ),
      ),
    );
  }
}
