import 'package:flutter/material.dart';

class CustomFormDescriptionFieldWithSubmit extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int? maxLines;
  final double minHeight;
  final double fontSize;
  final double borderRadius;
  final double width;
  final int? maxLength;
  final TextInputType keyboardType;
  final Color textColor;
  final Color borderColor;
  final Color hintColor;
  final Function()? onSubmitted;

  const CustomFormDescriptionFieldWithSubmit({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLines,
    this.minHeight = 48,
    this.fontSize = 14,
    this.borderRadius = 8,
    required this.width,
    this.maxLength,
    this.keyboardType = TextInputType.multiline,
    required this.textColor,
    required this.borderColor,
    required this.hintColor,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight,
      ),
      width: width,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => onSubmitted?.call(),
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: fontSize,
          ),
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
        ),
      ),
    );
  }
}
