// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';

import '../helpers/layout.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hinttext;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final EdgeInsets? padding;
  final double? radius;
  final Color? fillColor;
  final bool? enabled;
  final double? height;
  var validate;
  final Widget? suffix;
  var onchange;
  int? maxlength;
  var errorcolor;
  CustomTextField(
      {Key? key,
      this.labelText,
      this.onchange,
      required this.controller,
      this.keyboardType,
      this.textInputAction,
      this.prefixIcon,
      this.suffixIcon,
      this.radius,
      this.fillColor,
      this.padding,
      this.obscureText = false,
      this.enabled = true,
      this.height,
      this.validate,
      this.hinttext,
      this.suffix,
      this.errorcolor,
      this.maxlength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 20, right: 20.0),
      child: TextFormField(
        maxLength: maxlength,
        validator: validate,
        onChanged: onchange,
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: controller,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: errorcolor ?? Color(0xffff0006)),
          counter: Text(''),
          fillColor: fillColor,
          filled: fillColor != null ? true : false,
          hintText: hinttext,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppLayout.getHeight(radius ?? 10),
            ),
          ),
          labelText: labelText,
          suffix: suffix,
          labelStyle: TextStyle(
            color: blackcolor,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
