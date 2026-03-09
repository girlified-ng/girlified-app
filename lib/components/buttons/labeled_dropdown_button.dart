import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:girlified/components/buttons/custom_dropdown_button.dart';

class LabeledDropdownSelector extends StatelessWidget {
  final String label;
  final String? sublabel;
  final List<String> items;
  final Function(String?) onChanged;
  final String? value;

  const LabeledDropdownSelector({
    super.key,
    required this.label,
    this.sublabel,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    log('[VALUE] : $value');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitleText(
          weight: FontWeight.w400,
          text: label,
        ),
        if (sublabel != null)
          BodyText(
            text: sublabel!,
            color: AppColors.textTertiaryColor,
          ),
        const SizedBox(height: AppSizes.vertical_3),
        CustomDropdownButton(
          dropDownItems: items,
          onChanged: onChanged,
          value: value,
        ),
      ],
    );
  }
}
