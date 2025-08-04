// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class CustomFormPasswordField extends StatefulWidget {
  final String hintText;
  bool hidePassword;
  Color? background;
  Color? fontColor;
  Color? borderColor;
  Color? hintColor;
  double? borderRadius;
  double? height;
  ImageIcon? prefixIcon;
  final bool showSuffixIcon;
  TextEditingController? controller;
  CustomFormPasswordField({
    super.key,
    this.prefixIcon,
    this.background,
    this.height,
    this.borderRadius,
    this.fontColor,
    this.borderColor,
    this.hintColor,
    required this.showSuffixIcon,
    required this.hidePassword,
    this.controller,
    required this.hintText,
  });

  @override
  State<CustomFormPasswordField> createState() =>
      _CustomFormPasswordFieldState();
}

class _CustomFormPasswordFieldState extends State<CustomFormPasswordField> {
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.maxFinite,
      height: widget.height ??
          (screenHeight < 600 ? (screenHeight * 0.08) : (screenHeight * 0.06)),
      decoration: BoxDecoration(
        color: widget.background ?? Colors.transparent,
        border: Border.all(
          color: widget.borderColor ?? AppColors.grayColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
      ),
      child: TextFormField(
        focusNode: unitCodeCtrlFocusNode,
        onTap: () {
          FocusScope.of(context).requestFocus(unitCodeCtrlFocusNode);
        },
        obscureText: widget.hidePassword,
        controller: widget.controller ?? widget.controller,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          contentPadding: EdgeInsets.only(
            left: 10,
            right: 20,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.showSuffixIcon == true
              ? InkWell(
                  onTap: () {
                    setState(() {
                      widget.hidePassword = !widget.hidePassword;
                    });
                  },
                  child: Icon(
                    FluentIcons.eye_12_regular,
                    size: 16,
                    color: widget.hidePassword == true
                        ? AppColors.grayColor
                        : AppColors.buttonPrimaryColor,
                  ),
                )
              : const SizedBox(),
          hintStyle: TextStyle(
            fontSize: 14,
            color: widget.hintColor ?? AppColors.whiteColor,
          ),
        ),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: widget.fontColor ?? AppColors.whiteColor,
        ),
      ),
    );
  }
}
