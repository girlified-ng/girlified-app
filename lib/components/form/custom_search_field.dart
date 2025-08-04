// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';

class CustomSearchField extends StatefulWidget {
  String? hintText;
  var maxLines;
  bool? readOnly;
  Color? textColor;
  Color? background;
  Color? hintColor;
  double? borderWidth;
  Color? borderColor;
  final double height;
  double? width;
  double? paddingTop;
  int? maxLength;
  double? paddingLeft;
  double? paddingRight;
  double? paddingBottom;
  double? borderRadius;
  double? fontSize;
  TextAlign? textAlign;
  ImageIcon? prefixIcon;
  ImageIcon? suffixIcon;
  String? prefixType;
  TextEditingController? controller;
  TextInputType? keyboardType;
  FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted; // New callback for submission
  final VoidCallback? onEditingComplete;

  CustomSearchField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixType,
    this.borderWidth,
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
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    required this.height,
    required this.maxLines,
    required this.hintColor,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width ?? double.maxFinite,
      decoration: BoxDecoration(
        color: widget.background ?? Colors.transparent,
        border: Border.all(
          width: widget.borderWidth ?? 1,
          color: widget.borderColor ?? AppColors.grayColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
      ),
      child: Center(
        child: TextFormField(
          focusNode: widget.focusNode ?? unitCodeCtrlFocusNode,
          onTap: () {
            FocusScope.of(context).requestFocus(unitCodeCtrlFocusNode);
          },
          readOnly: widget.readOnly ?? false,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength ?? 255,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          textAlign: widget.textAlign ?? TextAlign.left,
          controller: widget.controller ?? widget.controller,
          keyboardType: widget.keyboardType ?? TextInputType.multiline,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText ?? '',
            contentPadding: EdgeInsets.only(
              left: widget.paddingLeft ?? 20,
              right: widget.paddingRight ?? 0,
              top: widget.paddingTop ?? 0,
              bottom: widget.paddingBottom ?? 0,
            ),
            counterText: "",
            prefixIcon: widget.prefixIcon ?? widget.prefixIcon,
            suffixIcon: widget.suffixIcon ?? widget.suffixIcon,
            hintStyle: TextStyle(
              color: widget.hintColor,
              fontSize: widget.fontSize ?? 14,
            ),
            prefixStyle: TextStyle(fontSize: 10),
          ),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: widget.fontSize ?? 16,
            color: widget.textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
