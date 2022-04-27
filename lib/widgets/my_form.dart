import 'package:flutter/material.dart';

import '../utils/base_color.dart';

class MyForm extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool secureText;
  final TextStyle? hintStyle;
  final double borderRadius;
  final TextCapitalization textCapitalization;
  final TextStyle? textStyle;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDense;

  const MyForm({
    Key? key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.secureText = false,
    this.hintStyle,
    this.borderRadius = 16,
    this.textCapitalization = TextCapitalization.none,
    this.textStyle,
    this.minLines,
    this.maxLines,
    this.textInputAction,
    this.contentPadding,
    this.isDense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: secureText,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      style: textStyle,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: isDense,
        contentPadding: contentPadding,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: BaseColor.lightGreen,
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
