import 'package:girlified/components/form/custom_form_description_field_with_submit.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/form_label_text.dart';
import 'package:girlified/components/form/custom_form_description_field.dart';

class FormDescriptionField extends StatefulWidget {
  final double? width;
  final double? height;
  final int? maxLength;
  final String label;
  final String hintText;
  final double labelSize;
  final bool showLabel;
  final double borderRadius;
  final bool showCharacterCount;
  final Color borderColor;
  final TextEditingController textController;
  final Function()? onSubmit;
  const FormDescriptionField({
    super.key,
    this.width,
    this.height,
    this.maxLength = 250,
    this.showLabel = true,
    required this.label,
    this.showCharacterCount = false,
    required this.hintText,
    this.labelSize = 16,
    required this.textController,
    this.borderRadius = 8,
    this.onSubmit,
    this.borderColor = AppColors.borderSecondaryColor,
  });

  @override
  State<FormDescriptionField> createState() => _FormDescriptionFieldState();
}

class _FormDescriptionFieldState extends State<FormDescriptionField> {
  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.textController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width ?? double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showLabel) ...[
            FormLabelText(
              text: widget.label,
              size: widget.labelSize,
            ),
            const SizedBox(height: AppSizes.vertical_3),
          ],
          CustomFormDescriptionFieldWithSubmit(
            hintText: widget.hintText,
            controller: widget.textController,
            maxLines: null,
            minHeight: 48,
            fontSize: 14,
            borderRadius: widget.borderRadius,
            width: double.maxFinite,
            maxLength: widget.maxLength,
            keyboardType: TextInputType.multiline,
            textColor: AppColors.primaryTextColor,
            borderColor: widget.borderColor,
            hintColor: AppColors.grayColor.withOpacity(0.3),
            onSubmitted: widget.onSubmit,
          ),
          if (widget.showCharacterCount && widget.maxLength != null) ...[
            const SizedBox(height: AppSizes.vertical_4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${widget.textController.text.length}/${widget.maxLength}',
                style: TextStyle(
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
