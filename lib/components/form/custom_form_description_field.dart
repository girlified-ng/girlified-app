// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:girlified/core/constants/colors.dart';

class CustomFormDescriptionField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final bool? readOnly;
  final Color? textColor;
  final Color? background;
  final Color? hintColor;
  final double? borderWidth;
  final Color? borderColor;
  final double? minHeight;
  final double? width;
  final double? paddingTop;
  final int? maxLength;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? borderRadius;
  final double? fontSize;
  final TextAlign? textAlign;
  final ImageIcon? prefixIcon;
  final ImageIcon? suffixIcon;
  final String? prefixType;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const CustomFormDescriptionField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixType,
    this.borderWidth,
    this.minHeight,
    this.width,
    this.background,
    this.textColor,
    this.paddingTop,
    this.paddingBottom,
    this.maxLength,
    this.paddingLeft,
    this.paddingRight,
    this.readOnly,
    this.textAlign,
    this.fontSize,
    this.hintText,
    this.controller,
    this.borderColor,
    this.borderRadius,
    this.keyboardType,
    this.focusNode,
    this.maxLines,
    required this.hintColor,
  }) : super(key: key);

  @override
  State<CustomFormDescriptionField> createState() =>
      _CustomFormDescriptionFieldState();
}

class _CustomFormDescriptionFieldState
    extends State<CustomFormDescriptionField> {
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: widget.width ?? double.maxFinite,
          constraints: BoxConstraints(
            minHeight: widget.minHeight ?? 50,
          ),
          decoration: BoxDecoration(
            color: widget.background ?? Colors.transparent,
            border: Border.all(
              width: widget.borderWidth ?? 1,
              color: widget.borderColor ?? AppColors.grayColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
          ),
          child: TextFormField(
            focusNode: widget.focusNode ?? unitCodeCtrlFocusNode,
            onTap: () {
              FocusScope.of(context).requestFocus(unitCodeCtrlFocusNode);
            },
            maxLines: widget.maxLines,
            readOnly: widget.readOnly ?? false,
            minLines: 1,
            maxLength: widget.maxLength,
            textAlign: widget.textAlign ?? TextAlign.left,
            controller: widget.controller,
            keyboardType: widget.keyboardType ?? TextInputType.multiline,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              // Dismiss the keyboard when the "done" button is pressed
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText ?? '',
              contentPadding: EdgeInsets.only(
                left: widget.paddingLeft ?? 20,
                right: widget.paddingRight ?? 20,
                top: widget.paddingTop ?? 10,
                bottom: widget.paddingBottom ?? 10,
              ),
              counterText: "",
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              hintStyle: TextStyle(
                color: widget.hintColor,
                fontSize: widget.fontSize ?? 14,
              ),
              prefixStyle: const TextStyle(fontSize: 10),
            ),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: widget.fontSize ?? 16,
              color: widget.textColor ?? Colors.white,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength),
            ],
          ),
        );
      },
    );
  }
}
