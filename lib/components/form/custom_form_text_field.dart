// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:girlified/core/constants/colors.dart';

class CustomFormTextField extends StatefulWidget {
  int maxLines;
  double? width;
  double height;
  bool? readOnly;
  int? maxLength;
  double? fontSize;
  String? hintText;
  Color? textColor;
  Color? hintColor;
  Color? background;
  Color? borderColor;
  double? paddingTop;
  String? prefixType;
  String? fontFamily;
  double? borderWidth;
  double? paddingLeft;
  double? paddingRight;
  double? borderRadius;
  TextAlign? textAlign;
  FocusNode? focusNode;
  double? paddingBottom;
  ImageIcon? prefixIcon;
  ImageIcon? suffixIcon;
  double? letterSpacing;
  FontWeight? fontWeight;
  TextInputType? keyboardType;
  final Function(String)? onChanged;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;

  CustomFormTextField({
    super.key,
    this.width,
    this.fontSize,
    this.hintText,
    this.readOnly,
    this.textAlign,
    this.maxLength,
    this.textColor,
    this.focusNode,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixType,
    this.paddingTop,
    this.fontWeight,
    this.fontFamily,
    this.background,
    this.controller,
    this.borderWidth,
    this.paddingLeft,
    this.borderColor,
    this.paddingRight,
    this.borderRadius,
    this.keyboardType,
    this.paddingBottom,
    this.letterSpacing,
    this.inputFormatters,
    required this.height,
    required this.maxLines,
    required this.hintColor,
  });

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  final FocusNode unitCodeCtrlFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width ?? double.maxFinite,
      decoration: BoxDecoration(
        color: widget.background ?? Colors.transparent,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
        border: Border.all(
          width: widget.borderWidth ?? 1,
          color: widget.borderColor ?? AppColors.grayColor.withOpacity(0.5),
        ),
      ),
      child: Center(
        child: TextFormField(
          focusNode: widget.focusNode ?? unitCodeCtrlFocusNode,
          onTap: () {
            FocusScope.of(context).requestFocus(unitCodeCtrlFocusNode);
          },
          inputFormatters: widget.inputFormatters ?? [],
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly ?? false,
          maxLength: widget.maxLength ?? 255,
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
            fontSize: widget.fontSize ?? 16,
            letterSpacing: widget.letterSpacing ?? 0,
            fontFamily: widget.fontFamily ?? 'Inter',
            color: widget.textColor ?? Colors.white,
            fontWeight: widget.fontWeight ?? FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
