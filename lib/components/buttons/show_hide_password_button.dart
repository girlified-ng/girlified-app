import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/components/text/body_text.dart';

class ShowHidePasswordButton extends StatelessWidget {
  final bool showPassword;
  final Function onTapHandler;
  const ShowHidePasswordButton(
      {super.key, required this.showPassword, required this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            onTapHandler();
          },
          overlayColor: const WidgetStatePropertyAll(
            Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.eye,
                size: 16,
              ),
              const SizedBox(width: AppSizes.horizontal_5),
              BodyText(
                text: showPassword == true ? 'Show' : 'Hide',
                weight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
