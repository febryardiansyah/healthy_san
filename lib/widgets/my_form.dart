import 'package:flutter/material.dart';

import '../utils/base_color.dart';

class MyForm extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool secureText;

  const MyForm({Key? key, this.hintText, this.controller, this.keyboardType,this.prefixIcon,this.suffixIcon,this.secureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: secureText,
      decoration: InputDecoration(
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: BaseColor.lightGreen,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
