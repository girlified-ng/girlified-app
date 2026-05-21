import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/form_label_text.dart';
import 'package:girlified/components/form/custom_form_text_field.dart';

class FormTextField extends StatelessWidget {
  final double? width;
  final String label;
  final String hintText;
  final int? maxLength;
  final double labelSize;
  final TextInputType? keyboardType;
  final TextEditingController textController;
  final bool showCharacterCount;
  final TextInputAction? textInputAction;
  const FormTextField({
    super.key,
    this.width,
    this.keyboardType,
    required this.label,
    required this.hintText,
    this.labelSize = 14,
    this.maxLength,
    required this.textController,
    this.showCharacterCount = false,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormLabelText(
            text: label,
            size: labelSize,
          ),
          const SizedBox(height: AppSizes.vertical_3),
          CustomFormTextField(
            hintText: hintText,
            controller: textController,
            maxLines: 1,
            height: 48,
            maxLength: maxLength,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            paddingTop: -3,
            borderRadius: 8,
            textColor: AppColors.primaryTextColor,
            hintColor: AppColors.grayColor.withOpacity(0.3),
            borderColor: AppColors.grayLightColor,
          ),
          if (showCharacterCount && maxLength != null) ...[
            const SizedBox(height: AppSizes.vertical_4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${textController.text.length}/$maxLength',
                style: const TextStyle(
                  color: AppColors.grayColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
