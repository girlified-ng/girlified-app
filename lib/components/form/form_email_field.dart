import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/form_label_text.dart';
import 'package:girlified/components/form/custom_form_text_field.dart';

class FormEmailField extends StatelessWidget {
  final double? width;
  final String label;
  final String hintText;
  final int? maxLength;
  final double labelSize;
  final TextInputType? keyboardType;
  final TextEditingController textController;
  final bool showCharacterCount;
  const FormEmailField({
    super.key,
    this.width,
    this.keyboardType,
    required this.label,
    required this.hintText,
    this.labelSize = 14,
    this.maxLength,
    required this.textController,
    this.showCharacterCount = false,
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontal_10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grayLightColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/icon_email.png',
                  width: 14,
                  height: 14,
                ),
                Expanded(
                  child: CustomFormTextField(
                    hintText: hintText,
                    controller: textController,
                    maxLines: 1,
                    height: 48,
                    maxLength: maxLength,
                    keyboardType: keyboardType,
                    paddingTop: -3,
                    borderRadius: 8,
                    paddingLeft: 10,
                    borderColor: Colors.transparent,
                    textColor: AppColors.primaryTextColor,
                    hintColor: AppColors.grayColor.withOpacity(0.3),
                  ),
                ),
              ],
            ),
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
